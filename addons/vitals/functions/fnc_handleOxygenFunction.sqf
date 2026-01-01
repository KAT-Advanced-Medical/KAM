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
#define MINIMUM_VENTILATION 2000
#define PACO2_MAX_CHANGE 0.05
#define PAO2_MAX_CHANGE 0.1
#define DEFAULT_FIO2 0.21
#define MINIMUM_DEPTH 0.2
#define BASE_MIN_VENT 5600
#define DEAD_SPACE_FRAC 0.22
#define RESP_Q 0.8
#define CO_REF 6.267584
private _respiratoryRate = 0;
private _respiratoryRateMult = _unit getVariable [QEGVAR(pharma,respiratoryRate), 1];
private _respiratoryDepth = 0;
private _demandVentilation = 0;
private _actualVentilation = 1;
private _alveolarVent = 1;
private _alveolarDemand = 1;
private _baseTidalVolume = 1;
private _etco2 = 15;
private _pao2 = 90;
private _targetPao2 = 90;
private _patternApplied = false;
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2  = (_bloodGas select 1);
private _baseRespiratoryDepth = DEFAULT_RESPIRATORY_DEPTH;
private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
private _airway = HAS_AIRWAY(_unit);
private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);

private _existingPFH = _unit getVariable [QGVAR(airwayMonitorPFH), -1];
if ((_existingPFH isEqualTo -1) && (!_airway || _paralysis)) then {
    private _pfhID = [{
        params ["_args", "_idPFH"];
        _args params ["_unit", "_elapsed", "_duration"];

        if (!HAS_AIRWAY(_unit) || (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1)) then {
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
    }, 1, [_unit, 0, 20 + floor random 45]] call CBA_fnc_addPerFrameHandler;

    _unit setVariable [QGVAR(airwayMonitorPFH), _pfhID];
};


if ((IN_CRDC_ARRST(_unit)) || !_airway || _paralysis) then {

    _demandVentilation = MINIMUM_VENTILATION;

    if (_airway) then {
        if (_unit getVariable [QEGVAR(breathing,BVMInUse), false]) then {
            _respiratoryRate = 20;
            _respiratoryDepth = 10;
        };
    };

    _actualVentilation = ((_respiratoryDepth / 10) * GET_KAT_SURFACE_AREA(_unit) * _respiratoryRate) max 1;

} else {

    private _co = [_unit] call FUNC(getCardiacOutput);
    private _coNorm = linearConversion [0.7, 1.4, _co / CO_REF, 0.85, 1.35, true];

    private _co2Drive = linearConversion [30, 50, _previousCyclePaco2, -1200, 1200, true];
    private _anaerobicDrive = linearConversion [1.0, 1.6, _anerobicPressure, 0, 3000, true];

    _demandVentilation =
        (BASE_MIN_VENT * _coNorm)
        + _co2Drive
        + _anaerobicDrive;

    _demandVentilation = _demandVentilation max MINIMUM_VENTILATION;
    _alveolarDemand =
    _demandVentilation * (1 - DEAD_SPACE_FRAC);

    private _icp = GET_ICP(_unit);
    private _map = GET_MAP(_unit);
    private _CPP = (_map - _icp) max 0;

    private _respDrive = linearConversion [80, 20, _CPP, 1.0, 0.1, true];
    _respDrive = _respDrive * (1 - (_opioidDepression * 0.6));
    _respDrive = _respDrive max 0 min 1;

    if (_unit getVariable [QEGVAR(breathing,BVMInUse), false]) then {
        _respiratoryRate  = 20;
        _respiratoryDepth = 12;
        _baseTidalVolume = (((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2);
        _tidalVolume = _baseTidalVolume;
        _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
        _patternApplied = true;
    };

    if (_unit getVariable [QEGVAR(breathing,attachedVent), false]) then {
        _respiratoryRate = (60 / (_unit getVariable [QEGVAR(breathing,ventRate), 5])) max 1;
        _respiratoryDepth = 12;
        _baseTidalVolume = (((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2);
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
        
        private _timer = _unit getVariable [QGVAR(ataxicTimer), 0];
        _timer = _timer - _deltaT;
    
        if (_timer <= 0) then {
            // Generate new chaotic pattern
            _unit setVariable [
                QGVAR(ataxicRate),
                floor random [5, 15, 35],
                true
            ];
            _unit setVariable [
                QGVAR(ataxicDepth),
                floor random [3, 10, 25],
                true
            ];
    
            _timer = 3 + random 3;
        };
    
        _unit setVariable [QGVAR(ataxicTimer), _timer, true];
    
        private _rate  = _unit getVariable [QGVAR(ataxicRate), 10];
        private _depth = _unit getVariable [QGVAR(ataxicDepth), 8];
    
        // Random apnea event (ataxic pause)
        if ((random 1) < 0.10) then {
            _respiratoryRate   = 0;
            _respiratoryDepth  = 0;
            _tidalVolume       = 0;
            _actualVentilation = 0;
        } else {
            _respiratoryRate  = _rate;
            _respiratoryDepth = _depth;
            _tidalVolume =
                GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10);
    
            _actualVentilation =
                (_tidalVolume * _respiratoryRate) * _bronchospasm;
        };
    
        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 2, true];
    };

    if (!_patternApplied && (_icp >= 38) && (_icp < 45)) then {

        private _timer = _unit getVariable [QGVAR(biotTimer), 0];
        private _state = _unit getVariable [QGVAR(biotState), "breath"];

        _timer = _timer - _deltaT;

        if (_timer <= 0) then {

            if (_state == "breath") then {
                _state = "apnea";
                _timer = 1 + random 3;
            } else {
                _state = "breath";
                _timer = 2 + random 3;
            };

            _unit setVariable [QGVAR(biotState), _state, true];
            _unit setVariable [QGVAR(biotTimer), _timer, true];
        } else {
            _unit setVariable [QGVAR(biotTimer), _timer, true];
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

        private _timer = _unit getVariable [QGVAR(agonalTimer), 0];

        _timer = _timer - _deltaT;
        _unit setVariable [QGVAR(agonalTimer), _timer, true];
        if (_timer <= 0) then {
            private _pause = 5 + random 15;
            private _gaspDur = 1.5 + random 1.0;

            _timer = _pause + _gaspDur;
            _unit setVariable [QGVAR(agonalTimer), _timer, true];

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
        TRACE_3(
            "BREATH_CTRL_DEMAND",
            _demandVentilation,
            _respDrive,
            _opioidDepression
        );

        private _targetRR =
            linearConversion [2500, 14000, _demandVentilation, 10, 28, true];

        _targetRR = (_targetRR min MAXIMUM_RR) * _respiratoryRateMult;
        _targetRR = _targetRR * (1 - (_opioidDepression * 0.6));

        TRACE_2(
            "BREATH_CTRL_TARGET_RR",
            _targetRR,
            _respiratoryRateMult
        );

        private _rrMem = _unit getVariable [QGVAR(rrMemory), _targetRR];
        _rrMem = _rrMem + ((_targetRR - _rrMem) * (_deltaT / 2.5));
        _unit setVariable [QGVAR(rrMemory), _rrMem];

        _respiratoryRate = _rrMem * _respDrive;
        TRACE_3(
            "BREATH_CTRL_RR",
            _rrMem,
            _respDrive,
            _respiratoryRate
        );

        _respiratoryDepth =
            ((DEFAULT_RESPIRATORY_DEPTH - (_opioidDepression / 1.5))
            max MINIMUM_DEPTH)
            * _respDrive;
        private _hypocapniaScale = linearConversion [25, 40, _previousCyclePaco2, 0.7, 1.0, true];
        _respiratoryDepth = _respiratoryDepth * _hypocapniaScale;
        private _baseVT =
            GET_KAT_SURFACE_AREA(_unit)
            * (_respiratoryDepth / 10);
        TRACE_2(
            "BREATH_CTRL_VT_BASE",
            _respiratoryDepth,
            _baseVT
        );

        // >>> REALISM FIX: VT falls with tachypnea
        if (_respiratoryRate > 22) then {
            private _excess = _respiratoryRate - 22;
            private _vtScale = linearConversion [0, 20, _excess, 1, 0.45, true];
            _baseVT = _baseVT * _vtScale;
            TRACE_3(
                "BREATH_CTRL_VT_SCALE",
                _respiratoryRate,
                _excess,
                _vtScale
            );
        };

        _actualVentilation =
            (_baseVT * _respiratoryRate)
            * _bronchospasm
            max 1;
        TRACE_3(
            "BREATH_CTRL_VENT",
            _baseVT,
            _respiratoryRate,
            _actualVentilation
        );
    };
};

_alveolarVent = (_actualVentilation * (1 - DEAD_SPACE_FRAC)) max 1;
private _paco2 = _previousCyclePaco2;

if (EGVAR(breathing,paco2Active)) then {
    private _ventRatio = _alveolarVent / (_alveolarDemand max 1);
    private _unconscious = !alive _unit || (_unit getVariable ["ACE_isUnconscious", false]);
    private _opioid = _unit getVariable [QEGVAR(pharma,opioidDepression), 0];
    private _cnsSuppression = (_unit getVariable [QEGVAR(surgery,sedated), 0])
        max (_opioid);
    private _basal = 1.0;

    private _cnsScale =
        linearConversion [0, 1, _cnsSuppression, 1.0, 0.65, true];
    if (_unconscious) then {
        _basalCO2Prod = 0.8;
    };
    private _basalCO2Prod = _basal * _cnsScale;
    private _co2Prod =
    _basalCO2Prod
    + ((_anerobicPressure - 1) max 0);
    private _targetPaco2 =
    DEFAULT_PACO2
    * (_co2Prod)
    / ((_alveolarVent / 4200) max 0.3);
    _targetPaco2 = _targetPaco2 max 15 min 120;

    private _deltaPaco2 = (_targetPaco2 - _previousCyclePaco2);
    _deltaPaco2 = _deltaPaco2 max (-PACO2_MAX_CHANGE * _previousCyclePaco2)
                           min ( PACO2_MAX_CHANGE * _previousCyclePaco2);

    _paco2 = _previousCyclePaco2 + _deltaPaco2;
};

private _fio2 = switch (true) do {
    case (!_airway): { 0 };
    case (_respiratoryRate == 0): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    default { DEFAULT_FIO2 };
};

private _pALVo2 =
(
    (_fio2 * (_baroPressure - 47))
    - (_paco2 / RESP_Q)
) max 1;
if (IN_CRDC_ARRST(_unit)) then {
    _etco2 = if (alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull])) then { 10 + (_paco2 / 6) } else { 0 };
} else {
    private _ventFrac = linearConversion [0.3, 1.0, _alveolarVent / (_alveolarDemand max 1), 0.2, 1.0, true];
    _pao2 = (_pALVo2 * _ventFrac) max 1;
};
private _arrestPerfusion = [1, (1 * EGVAR(breathing,SpO2_PerfusionMultiplier))] select ((IN_CRDC_ARRST(_unit)) && (EGVAR(breathing,SpO2_perfusion)));
_pao2 = if (_previousCyclePao2 != _pao2) then { ([ (_previousCyclePao2 - ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyNegative) * _arrestPerfusion) * _deltaT)) , (_previousCyclePao2 + ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT))] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };
private _baseConst =
    7.4 - log(24 / (0.03 * 39.9));

private _phConst =
    _baseConst - 0.015 * (_temperature - 37);
    
private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];

private _pH =
(_phConst + log(24 / (0.03 * _paco2)))
- (_externalPh / 420)
- ((_aceAnFatigue / 2) / 3);    

private _p50 = ((25 - (((_pH / DEFAULT_PH) - 1) * 150)) max 15) min 40;
private _o2Sat = ((_pao2^2.7) / (_p50^2.7 + _pao2^2.7)) min 0.999;
TRACE_4("BREATH_REST",
    _respiratoryRate,
    _demandVentilation,
    _paco2,
    _pao2
);
_unit setVariable [QEGVAR(breathing,breathRate), _respiratoryRate, _syncValues];
_unit setVariable [VAR_RESPIRATORY_DEPTH, _respiratoryDepth, _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
