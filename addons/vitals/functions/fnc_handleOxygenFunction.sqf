#define DEBUG_MODE_FULL
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

#define MAXIMUM_RR 40
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
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2 = (_bloodGas select 1);
private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
private _occlusionArray = _unit getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
private _obstructionArray = _unit getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
private _airwayStatus = _unit getVariable [QEGVAR(airway,airwayStatus), [0, 0, 0]];
private _catastrophicState = _unit getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));
for "_i" from 0 to 2 do {
    if ((_airwayStatus select _i) > 0) then {
        _obstructionArray set [_i, 0];
        _occlusionArray set [_i, 0];
    };
};
if ((_unit getVariable [QEGVAR(airway,airway_item), ""]) isEqualTo "NPA") then {
    _occlusionArray = _occlusionArray select [1,2];
    _obstructionArray = _obstructionArray select [1,2];
    _hasCatastrophicAirway = _catastrophicState select 1;
};
private _occlusion = (_occlusionArray findIf { _x > 4 }) != -1;
private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;

private _airway = false;
private _noETT = (_patient getVariable [QEGVAR(airway,airway_item), ""] isNotEqualTo "ETT");
private _noSurgicalAirway = (_patient getVariable [QEGVAR(airway,airway_item), ""] isNotEqualTo "Surgical_Airway");
private _noOverstretch = _patient getVariable [QEGVAR(airway,overstretch), false];
if (((((_obstruction && !_noOverstretch) || _occlusion) && _noETT) || _hasCatastrophicAirway) && _noSurgicalAirway) then {
    _airway = false;
};
private _airwayResistance = 1;
if (selectMax (_obstructionArray) > 0) then {
    _airwayResistance = 0.2;
};
if (selectMax (_occlusionArray) > 0) then {
    private _occlusion = selectMax (_occlusionArray);
    _airwayResistance = linearConversion [0, 6, _occlusion, 1, 0.2, true];
};
private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);
private _existingPFH = _unit getVariable [QGVAR(airwayMonitorPFH), -1];
if ((_existingPFH isEqualTo -1) && (IN_CRDC_ARRST(_unit) || _airway || _paralysis)) then {
    private _pfhID = [
    {
        params ["_args", "_idPFH"];
        _args params ["_unit", "_elapsed", "_duration"];
        private _airwayItem = _unit getVariable [QEGVAR(airway,airway_item), ""];
        private _noETT = (_airwayItem isNotEqualTo "ETT");
        private _noSurgicalAirway = (_airwayItem isNotEqualTo "Surgical_Airway");
        private _occlusionArray = _unit getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
        private _obstructionArray = _unit getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
        if ((_unit getVariable [QEGVAR(airway,airway_item), ""]) isEqualTo "NPA") then {
            _occlusionArray = _occlusionArray select [1,2];
            _obstructionArray = _obstructionArray select [1,2];
        };
        private _occlusion = (_occlusionArray findIf { _x > 4 }) != -1;
        private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;
        private _catastrophicState = _unit getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
        private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));

        private _airway = false;
        if ((((_obstruction || _occlusion) && _noETT) || _hasCatastrophicAirway) && _noSurgicalAirway) then {
            _airway = true;
        };

        private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);
        private _condition = IN_CRDC_ARRST(_unit) || _airway || _paralysis;
        if (_condition) then {
            _elapsed = _elapsed + 1;
            _args set [1, _elapsed];
            if (_elapsed >= _duration) then {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
                [_unit, true] call ACEFUNC(medical,setUnconscious);
                _unit setVariable [QGVAR(airwayMonitorPFH), -1];
            };
        } else {
            [_idPfh] call CBA_fnc_removePerFrameHandler;
            _unit setVariable [QGVAR(airwayMonitorPFH), -1];
        };
    },
    1,
    [_unit, 0, (20 + (floor random 45))]
    ] call CBA_fnc_addPerFrameHandler;
    _unit setVariable [QGVAR(airwayMonitorPFH), _pfhID];
};
if ((IN_CRDC_ARRST(_unit)) || _airway || _paralysis) then { 
    // When in arrest, there should be no effecive breaths but still a minimum O2 demand. Zero O2 demand would mean a dead patient. Actual ventilation is 1 to prevent issues in the gas tension functions
    _demandVentilation = MINIMUM_VENTILATION;
    _respiratoryDepression = 1;
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
    _actualVentilation = (1 * _airwayResistance * _bronchospasm) max 0.2;
} else {
    // Ventilatory Demand comes from Heart Rate with increase demand from PaCO2 levels 
    _demandVentilation = ((((_actualHeartRate * HEART_RATE_CO2_MULTIPLIER) / _anerobicPressure) + ((_previousCyclePaco2 - DEFAULT_PACO2) * 200)) max MINIMUM_VENTILATION);

    // Respiratory Rate is supressed by Opioids 
    
    private _baseRespiratoryDepth = ((DEFAULT_RESPIRATORY_DEPTH) - (_opioidDepression / 1.5));
    private _baseTidalVolume = GET_KAT_SURFACE_AREA(_unit) * (_baseRespiratoryDepth / 10);

    _respiratoryRate = [(((_demandVentilation / _baseTidalVolume)) min MAXIMUM_RR) * _respiratoryRateMult, 20] select (_unit getVariable [QEGVAR(breathing,BVMInUse), false]);
    
    // If respiratory rate is low due to PaCO2, it starts increasing faster to compensate
    if (_previousCyclePaco2 > 50) then { _respiratoryRate = (_respiratoryRate + ((_previousCyclePaco2 - 50) * 0.2)) min MAXIMUM_RR};

    private _tidalVolume = _baseTidalVolume;
    if (_respiratoryRate > 20) then {
    private _excessRR = _respiratoryRate - 25;
    private _scaleFactor = 1 - (0.03 * _excessRR);  // reduces ~3% per breath over 25
    _tidalVolume = _baseTidalVolume * (_scaleFactor max 0.5); // never drops below 50% of base
    };

    private _respiratoryDepth = _baseRespiratoryDepth;
    if (_respiratoryRate > 20) then {
    private _excessRR = _respiratoryRate - 25;
    private _scaleFactor = 1 - (0.03 * _excessRR);  // reduces ~3% per breath over 25
    _respiratoryDepth = [(_baseRespiratoryDepth * (_scaleFactor max 0.5)), 10] select (_unit getVariable [QEGVAR(breathing,BVMInUse), false]); // never drops below 50% of base
    };

    // Obstructed airway reduces effective ventilation
    _actualVentilation = (_tidalVolume * _respiratoryRate) * _airwayResistance * _bronchospasm;
};

private _paco2 = 40;

if (EGVAR(breathing,paco2Active)) then {
    // The greater the imbalance between CO2 explusion and O2 intake, the higher PaCO2 gets
    _paco2 = if ((_demandVentilation / _actualVentilation) == 1) then { _previousCyclePaco2 + (PACO2_MAX_CHANGE min (-PACO2_MAX_CHANGE max ((DEFAULT_PACO2 + ((_anerobicPressure max 1) - 1) * 150) - _previousCyclePaco2))) } else { [ _previousCyclePaco2 - (PACO2_MAX_CHANGE * _deltaT), _previousCyclePaco2 + (PACO2_MAX_CHANGE * _deltaT)] select ((_demandVentilation / _actualVentilation) > 1) };                                    
};

// Generated ETCO2 quadratic. Ensures ETCO2 moves with Respiratory Rate and is constantly below PaCO2 
private _etco2 = [((((_paco2 - 3) - ((-0.0416667 * (_respiratoryRate^2)) + (3.09167 * (_respiratoryRate))) * (_respiratoryDepth)) - DEFAULT_ETCO2) max 10), 0] select (IN_CRDC_ARRST(_unit));
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
    case (_airway): { 
        [0, DEFAULT_FIO2] select ((_unit getVariable [QEGVAR(airway,recovery), false]) || (_unit getVariable [QEGVAR(airway,overstretch), false])) 
    };
    case ((_respiratoryRate == 0) && (EGVAR(breathing,SpO2_perfusion))): { 0 };
    case ((_unit getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 0) || (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]] select 1) ||(_unit getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 0) || (_unit getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]] select 1)): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): { 1 };
    default { DEFAULT_FIO2 };
};

// Alveolar Gas equation. PALVO2 is largely impacted by Barometric Pressure and FiO2
private _pALVo2 = ((_fio2 * (_baroPressure - 47)) - (_paco2 / _anerobicPressure)) max 1;

// PaO2 cannot be higher than PALVO2 and comes from ventilation shortage multipled by RBC volume
private _pao2 = ((DEFAULT_PAO2 - ((linearConversion [2400, 0, ((GET_BODY_FLUID(_unit) select 0) max 500), 0, 1, true]) * 50)) - ((2700 / (((GET_BODY_FLUID(_unit) select 0) max 500)) * ((_demandVentilation - _actualVentilation) / 120)))) min _pALVo2;
private _airwayO2TransferMultiplier = 1;
if (selectMax (_occlusionArray) > 0) then {
    private _occlusion = selectMax (_occlusionArray);
    _airwayO2TransferMultiplier = linearConversion [0, 6, _occlusion, 1, 0.2, true];
};
if (selectMax (_obstructionArray) > 0) then {
    _airwayO2TransferMultiplier = 0.5;
};
_pao2 = ((_pao2 * _airwayO2TransferMultiplier) min _pALVo2);

TRACE_5("o2",_pao2,DEFAULT_ECB,((GET_BODY_FLUID(_unit) select 0) max 500),_demandVentilation,_actualVentilation);
private _arrestPerfusion = [1, (1 * EGVAR(breathing,SpO2_PerfusionMultiplier))] select (((IN_CRDC_ARRST(_unit)) || _airway || _paralysis) && (EGVAR(breathing,SpO2_perfusion)));
// PaO2 moves in controlled steps to prevent hard movements when Ventilation Demand spikes
_pao2 = if (_previousCyclePao2 != _pao2) then { ([ (_previousCyclePao2 - ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyNegative) * _arrestPerfusion) * _deltaT)) , (_previousCyclePao2 + ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT))] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };

private _ecbFactor = linearConversion [2700, 0, ((GET_BODY_FLUID(_unit) select 0) max 500), 1, 0.5, true];
// Oxy-Hemo Dissociation Curve, driven by PaO2 with shaping done by pH 
private _o2Sat = ((_pao2 max 1)^2.7 / ((25 - (((_pH / DEFAULT_PH) - 1) * 150))^2.7 + _pao2^2.7)) min 0.999;

_o2Sat = _o2Sat * _ecbFactor;

if (_unit getVariable [QEGVAR(airway,overstretch), false]) then {
    _o2Sat = _o2Sat * 0.95;
};
TRACE_3("o22",_o2Sat,((_pao2 max 1)^2.7 / ((25 - (((_pH / DEFAULT_PH) - 1) * 150))^2.7 + _pao2^2.7)),_ecbFactor);
_unit setVariable [QEGVAR(breathing,breathRate), (_respiratoryRate max 0), _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
