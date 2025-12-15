#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Updates the respiratory variables 
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Heart Rate <NUMBER>
 * 2: Anerobic Pressure <NUMBER>
 * 3: Blood Gas Array <ARRAY>
 * 4: Temperature <NUMBER>
 * 5: Barometric Pressure <NUMBER>
 * 6: Opioid Depression <NUMBER>
 * 7: Time since last update <NUMBER>
 * 8: Sync value? <BOOL> 
 *
 * ReturnValue:
 * Current O2 Saturation <NUMBER>
 *
 * Example:
 * [player, 80, 0.8, [40,90,0.96,24,7.4], 37, 760, 0, 1, true] call kat_vitals_fnc_handleOxygenFunction;
 *
 * Public: No
 */

params ["_unit", "_actualHeartRate", "_anerobicPressure", "_bloodGas", "_temperature", "_baroPressure", "_opioidDepression", "_aceAnFatigue", "_deltaT", "_syncValues"];

#define MAXIMUM_RR 35
#define HEART_RATE_CO2_MULTIPLIER 60
#define MINIMUM_VENTILATION 2000
#define PACO2_MAX_CHANGE 0.05
#define PAO2_MAX_CHANGE 0.1
#define DEFAULT_FIO2 0.21
#define MINIMUM_DEPTH 0.2

private _respiratoryRate = 0;
private _respiratoryRateMult = _unit getVariable [QEGVAR(pharma,respiratoryRate), 1];
private _respiratoryDepression = 0;
private _respiratoryDepth = 0;
private _demandVentilation = 0;
private _actualVentilation = 0;
private _etco2 = 0;
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2 = (_bloodGas select 1);
private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
private _airway = HAS_AIRWAY(_unit);
private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);
private _existingPFH = _unit getVariable [QGVAR(airwayMonitorPFH), -1];
if ((_existingPFH isEqualTo -1) && (!_airway || _paralysis)) then {
    private _pfhID = [
    {
        params ["_args", "_idPFH"];
        _args params ["_unit", "_elapsed", "_duration"];
        private _airway = HAS_AIRWAY(_unit);

        private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);
        private _condition = (!_airway || _paralysis);
        if (_condition) then {
            _elapsed = _elapsed + 1;
            _args set [1, _elapsed];
            if (_elapsed >= _duration) then {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
                [_unit, true] call ACEFUNC(medical,setUnconscious);
                _unit setVariable [QGVAR(airwayMonitorPFH), -1];
            };
        } else {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _unit setVariable [QGVAR(airwayMonitorPFH), -1];
        };
    },
    1,
    [_unit, 0, (20 + (floor random 45))]
    ] call CBA_fnc_addPerFrameHandler;
    _unit setVariable [QGVAR(airwayMonitorPFH), _pfhID];
};
if ((IN_CRDC_ARRST(_unit)) || !_airway || _paralysis) then { 
    // When in arrest, there should be no effecive breaths but still a minimum O2 demand. Zero O2 demand would mean a dead patient. Actual ventilation is 1 to prevent issues in the gas tension functions
    _demandVentilation = MINIMUM_VENTILATION;
    _respiratoryDepression = 1;
    if (_airway) then {
        switch (true) do {
            case (_unit getVariable [QEGVAR(breathing,BVMInUse), false]): {
            _respiratoryRate = 20;
            };
            case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): {
            _respiratoryRate = (60 / (_unit getVariable [QEGVAR(breathing,ventRate), 2]));
            };
            default {
            _respiratoryRate = 0;
            };
        };
        _respiratoryDepth = [0, 10] select ((_unit getVariable [QEGVAR(breathing,BVMInUse), false]) || (_unit getVariable [QEGVAR(breathing,attachedVent), false]));
        private _baseTidalVolume = ((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2;;
        _actualVentilation = (_baseTidalVolume * _respiratoryRate) max 1;
    } else {
        _respiratoryRate = 0;
        _actualVentilation = 1;
        _respiratoryDepth = 0;
    };  
} else {
    

    private _contractility = (_unit getVariable [QEGVAR(pharma,heartContractility), 1]) max 0.2;
    private _contractilityMult = linearConversion [0.2, 1.8, _contractility, 0.5, 1.5, true];
    _demandVentilation = (((((_actualHeartRate / _contractilityMult) * HEART_RATE_CO2_MULTIPLIER) / _anerobicPressure) + ((_previousCyclePaco2 - DEFAULT_PACO2) * 200)) max MINIMUM_VENTILATION);

    // Respiratory Rate is supressed by Opioids 
    
    private _baseRespiratoryDepth = ((DEFAULT_RESPIRATORY_DEPTH) - (_opioidDepression / 1.5));
    private _baseTidalVolume = GET_KAT_SURFACE_AREA(_unit) * (_baseRespiratoryDepth / 10);
    private _icp = GET_ICP(_unit);
    private _cardiacOutput = [_unit] call FUNC(getCardiacOutput);
    private _tidalVolume = 0;
    private _patternApplied = false;
    if (_unit getVariable [QEGVAR(breathing,BVMInUse), false]) then {
        _respiratoryRate  = 20;
        _respiratoryDepth = 12;
        private _baseTidalVolume = (((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2);
        _tidalVolume = _baseTidalVolume;
        _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
        _patternApplied = true;
    };

    if (_unit getVariable [QEGVAR(breathing,attachedVent), false]) then {
        _respiratoryRate = (60 / (_unit getVariable [QEGVAR(breathing,ventRate), 5])) max 1;
        _respiratoryDepth = 12;
        private _baseTidalVolume = (((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2);
        _tidalVolume = _baseTidalVolume;
        _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
        _patternApplied = true;
    };
    if (!_patternApplied && (_icp >= 20) && (_icp < 32)) then {
        private _t = CBA_missionTime;
        private _frequency = 1/120;          // 1 Hz = one full sine wave per second
        private _amplitude = 5;          // peak is +5, trough is -5
        private _phase = 0;              // no phase shift

        private _value = (sin ((_t * _frequency * 360) + _phase)) * _amplitude;
        private _env = linearConversion [-5, 5, _value, 0, 2, true];
        if (_env < 0.15) then {
            _respiratoryRate  = 0;
            _respiratoryDepth = 0;
            _tidalVolume      = 0;
            _actualVentilation = 1;
            _patternApplied = true;
        } else {
            _respiratoryRate  = 15 * _env;
            _respiratoryDepth = 10 * _env;
            _tidalVolume      = GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10);
            _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
            _patternApplied = true;
        };

        _unit setVariable [QGVAR(breathingState), 1, true];
    };

    if (!_patternApplied && (_icp >= 32) && (_icp < 38)) then {
        private _rate = floor random [5, 15, 35];
        private _depth = floor random [3, 10, 25];

        if ((random 1) < 0.10) then {
            _respiratoryRate = 0;
            _respiratoryDepth = 0;
            _tidalVolume = 0;
            _actualVentilation = 1;
        } else {
            _respiratoryRate = _rate;
            _respiratoryDepth = _depth;
            _tidalVolume = GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10);
            _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
        };

        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 2, true];
    };

    if (!_patternApplied && (_icp >= 38) && (_icp < 45)) then {

        private _timer = _unit getVariable [QEGVAR(breathing,biotTimer), 0];
        private _state = _unit getVariable [QEGVAR(breathing,biotState), "breath"];

        _timer = _timer - _deltaT;

        if (_timer <= 0) then {

            if (_state == "breath") then {
                _state = "apnea";
                _timer = 1 + random 3;
            } else {
                _state = "breath";
                _timer = 2 + random 3;
            };

            _unit setVariable [QEGVAR(breathing,biotState), _state, true];
            _unit setVariable [QEGVAR(breathing,biotTimer), _timer, true];
        } else {
            _unit setVariable [QEGVAR(breathing,biotTimer), _timer, true];
        };

        if (_state == "apnea") then {
            _respiratoryRate = 0;
            _respiratoryDepth = 0;
            _tidalVolume = 0;
            _actualVentilation = 1;
        } else {
            _respiratoryRate = 4 + floor (random 4);
            _respiratoryDepth = _baseRespiratoryDepth * (0.2 + random 1.2);
            _tidalVolume = GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10);
            _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
            playSound3D [QPATHTOF_SOUND(audio\gasp.ogg), _unit, false, getPosASL _unit, 6, 1, 8];
        };

        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 3, true];
    };

    if (!_patternApplied && (_icp >= 45)) then {

        private _timer = _unit getVariable [QEGVAR(breathing,agonalTimer), 0];

        _timer = _timer - _deltaT;
        _unit setVariable [QEGVAR(breathing,agonalTimer), _timer, true];
        if (_timer <= 0) then {
            private _pause = 5 + random 15;
            private _gaspDur = 1.5 + random 1.0;

            _timer = _pause + _gaspDur;
            _unit setVariable [QEGVAR(breathing,agonalTimer), _timer, true];

            _respiratoryRate = 0;
            _respiratoryDepth = 0;
            _tidalVolume = 0;
            _actualVentilation = 1;

            _patternApplied = true;
        }
        else
        {
            if (_timer < 2.0) then {
                _respiratoryRate = 1;
                _respiratoryDepth = _baseRespiratoryDepth * (2.0 + random 1.0);
                _tidalVolume = GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10);
                _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
                playSound3D [QPATHTOF_SOUND(audio\gasp.ogg), _unit, false, getPosASL _unit, 6, 1, 8];
            } else {
                _respiratoryRate = 0;
                _respiratoryDepth = 0;
                _tidalVolume = 0;
                _actualVentilation = 1;
            };

            _patternApplied = true;
            _unit setVariable [QGVAR(breathingState), 4, true];
        };
    };
    if (!_patternApplied) then {
    _unit setVariable [QGVAR(breathingState), 0, true];
    _respiratoryRate = (((_demandVentilation / _baseTidalVolume) * _respiratoryRateMult) min (MAXIMUM_RR * _respiratoryRateMult));

    if (!_patternApplied && (_previousCyclePaco2 > 50)) then { _respiratoryRate = (_respiratoryRate + ((_previousCyclePaco2 - 50) * 0.2)) min ((MAXIMUM_RR * _respiratoryRateMult) min 60)};

    _tidalVolume = _baseTidalVolume;
    if (_respiratoryRate > 25) then {
    private _excessRR = _respiratoryRate - 25;
    private _scaleFactor = 1 - (0.025 * _excessRR);  // reduces ~3% per breath over 25
    _tidalVolume = _baseTidalVolume * (_scaleFactor max 0.4); // never drops below 50% of base
    };
    _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
    };
};
private _paco2 = 40;

if (EGVAR(breathing,paco2Active)) then {
    // The greater the imbalance between CO2 explusion and O2 intake, the higher PaCO2 gets
    _paco2 = if ((_demandVentilation / _actualVentilation) == 1) then { _previousCyclePaco2 + (PACO2_MAX_CHANGE min (-PACO2_MAX_CHANGE max ((DEFAULT_PACO2 + ((_anerobicPressure max 1) - 1) * 150) - _previousCyclePaco2))) } else { [ _previousCyclePaco2 - (PACO2_MAX_CHANGE * _deltaT), _previousCyclePaco2 + (PACO2_MAX_CHANGE * _deltaT)] select ((_demandVentilation / _actualVentilation) > 1) };                                    
};
// Generated ETCO2 quadratic. Ensures ETCO2 moves with Respiratory Rate and is constantly below PaCO2 
if (IN_CRDC_ARRST(_unit)) then {
    if (alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull])) then {
        // CPR is ongoing
        _etco2 = (15 + (_paco2 / 40) - (((_unit getVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLeft), 1]) max 1) / (ACEGVAR(medical_statemachine,cardiacArrestTime)) * 10)) max 1;
    } else {
        _etco2 = 0;
    };
} else {
    _etco2 = (((-0.0416667 * (_respiratoryRate^2)) + (3.09167 * (_respiratoryRate))) * (_respiratoryDepth / 10 )) max 5;
};
TRACE_1("Etco2 4",_etco2);
private _externalPh = 0;
private _pH = 7.4;

if (EGVAR(pharma,kidneyAction)) then {
    // Extenal pH impacts from saline is included
    _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];

     private _phConstant = ((-0.00006653 * (_temperature ^ 2)) - (0.03268 * _temperature) + 7.4);

    // pH is from the Henderson-Hasselbalch equation
    _pH = (_phConstant + log(24 / ((0.03 * _paco2)))) - ((_externalPh max 1) / 2000) - ((_aceAnFatigue / 2) / 3);
};
// Fractional Oxygen when breathing normal air is 0.21, 1 when breathing 100% Oxygen, and 0 when no air is being brought into the lungs
private _fio2 = switch (true) do {
    case (!_airway): { 0 };
    case (_respiratoryRate == 0): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): { 1 };
    case ((_unit getVariable [QEGVAR(breathing,nasalCannula), false]) && ((IN_MED_FACILITY(_unit)) || (IN_MED_VEHICLE(_unit)))): { 0.95 };
    default { DEFAULT_FIO2 };
};

// Alveolar Gas equation. PALVO2 is largely impacted by Barometric Pressure and FiO2
private _pALVo2 = ((_fio2 * (_baroPressure - 47)) - (_paco2 / _anerobicPressure)) max 1;

// PaO2 cannot be higher than PALVO2 and comes from ventilation shortage multipled by RBC volume
private _pao2 = ((DEFAULT_PAO2 - ((linearConversion [2400, 0, ((GET_BODY_FLUID(_unit) select 0) max 500), 0, 2, true]) * 25)) - ((2700 / (((GET_BODY_FLUID(_unit) select 0) max 500)) * ((_demandVentilation - _actualVentilation) / 120)))) min _pALVo2;

TRACE_5("o2",_pao2,DEFAULT_ECB,((GET_BODY_FLUID(_unit) select 0) max 500),_demandVentilation,_actualVentilation);
private _arrestPerfusion = [1, (1 * EGVAR(breathing,SpO2_PerfusionMultiplier))] select ((IN_CRDC_ARRST(_unit)) && (EGVAR(breathing,SpO2_perfusion)));
// PaO2 moves in controlled steps to prevent hard movements when Ventilation Demand spikes
_pao2 = if (_previousCyclePao2 != _pao2) then { ([ (_previousCyclePao2 - ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyNegative) * _arrestPerfusion) * _deltaT)) , (_previousCyclePao2 + ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT))] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };
// Oxy-Hemo Dissociation Curve, driven by PaO2 with shaping done by pH 
private _o2Sat = ((_pao2 max 1)^2.7 / ((25 - (((_pH / DEFAULT_PH) - 1) * 150))^2.7 + _pao2^2.7)) min 0.999;

if (_unit getVariable [QEGVAR(airway,overstretch), false]) then {
    _o2Sat = _o2Sat * 0.95;
};
TRACE_2("o22",_o2Sat,((_pao2 max 1)^2.7 / ((25 - (((_pH / DEFAULT_PH) - 1) * 150))^2.7 + _pao2^2.7)));
_unit setVariable [QEGVAR(breathing,breathRate), (_respiratoryRate max 0), _syncValues];
_unit setVariable [VAR_RESPIRATORY_DEPTH, (_respiratoryDepth max 0), _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
