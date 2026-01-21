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

params ["_unit", "_actualHeartRate", "_anerobicPressure", "_bloodGas", "_temperature", "_baroPressure", "_opioidDepression", "_aceAnFatigue", "_aceAnReserve", "_deltaT", "_syncValues"];

#define MAXIMUM_RR 35
#define MINIMUM_VENTILATION 2000
#define PACO2_MAX_CHANGE 0.05
#define PAO2_MAX_CHANGE 0.1
#define DEFAULT_FIO2 0.21
#define MINIMUM_DEPTH 0.2
#define BASE_MIN_VENT 3600
#define DEAD_SPACE_FRAC 0.22
#define RESP_Q 0.8
#define CO_REF 0.10445973
#define BVM_MODE_NONE     0
#define BVM_MODE_ASSIST   1
#define BVM_MODE_CONTROL  2

#define BVM_MAX_RR        24
#define BVM_MIN_RR        10
#define BVM_MAX_VT        0.9
#define BVM_MIN_VT        0.35

#define DYSSYNC_PENALTY_MAX 0.35

#define RF_NONE        0
#define RF_IMPENDING   1
#define RF_ESTABLISHED 2
#define RF_COMPLETE    3
private _tidalVolume = 0;
private _respiratoryRate = 0;
private _respiratoryRateMult = _unit getVariable [QEGVAR(pharma,respiratoryRate), 1];
private _respiratoryDepth = 0;
private _demandVentilation = 0;
private _actualVentilation = 1;
private _alveolarVent = 1;
private _alveolarDemand = 1;
private _baseTidalVolume = 1;
private _etco2 = 37;
private _pao2 = 90;
private _ph = GET_PH(_unit);
private _respFatigue = _unit getVariable [QGVAR(respFatigue), 0];
private _do2Norm = _unit getVariable [QGVAR(oxygenDelivery), 1];
private _targetPao2 = 90;
private _patternApplied = false;
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2  = (_bloodGas select 1);
private _rfBurden = _unit getVariable [QGVAR(rfBurden), 0];
private _baseRespiratoryDepth = DEFAULT_RESPIRATORY_DEPTH;
private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
private _airway = HAS_AIRWAY(_unit);
private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);
private _bvmMode = BVM_MODE_NONE;
private _pulmonaryShunt = _unit getVariable [QGVAR(pulmonaryShunt), 0];
private _medLevel = _unit getVariable [QACEGVAR(medical,medicClass), getNumber (configOf _unit >> "attendant")];
private _providerSkill = linearConversion [0, 2, _medLevel, 0.4, 0.8];
private _bvmActive = _unit getVariable [QEGVAR(breathing,BVMInUse), false];
private _isArrest = IN_CRDC_ARRST(_unit);
if (_do2Norm < 0.4) then {
    _anerobicPressure = _anerobicPressure + ((0.5 - _do2Norm) * _deltaT);
};
private _canBreathe =
    _airway
    && !_paralysis
    && !_isArrest;
private _ventAttached =
    _bvmActive
    || (_unit getVariable [QEGVAR(breathing,attachedVent), false]);
if (_bvmActive) then {
    if (_paralysis || IN_CRDC_ARRST(_unit) || !_airway) then {
        _bvmMode = BVM_MODE_CONTROL;
    } else {
        _bvmMode = BVM_MODE_ASSIST;
    };
};
if (_bvmMode == BVM_MODE_NONE) then {
    _unit setVariable [QGVAR(bvmDyssync), 0, true];
};
private _bvmTargetRR = 20;
private _bvmTargetDepth = 10;
private _monitor  = _unit getVariable [QEGVAR(breathing,etco2Monitor), []];
if (_monitor isNotEqualTo []) then {
    _bvmTargetRR =
    linearConversion [25, 80, _previousCyclePaco2, BVM_MIN_RR, BVM_MAX_RR, true];

    _bvmTargetDepth =
    linearConversion [25, 80, _previousCyclePaco2, 8, 14, true];
};
private _bvmRRMem = _unit getVariable [QGVAR(bvmRRMem), _bvmTargetRR];
_bvmRRMem = _bvmRRMem + ((_bvmTargetRR - _bvmRRMem) * (_deltaT / 4));
_unit setVariable [QGVAR(bvmRRMem), _bvmRRMem];
_bvmTargetRR = _bvmRRMem;
private _bvmVT =
(
    GET_KAT_SURFACE_AREA(_unit)
    * (_bvmTargetDepth / 10)
) min BVM_MAX_VT max BVM_MIN_VT;

private _bvmVent =
    (_bvmVT * _bvmTargetRR) * _bronchospasm;
private _co = [_unit] call FUNC(getCardiacOutput);
private _coNorm = linearConversion [0.7, 1.4, _co / CO_REF, 0.85, 1.35, true];
private _co2Error = _previousCyclePaco2 - DEFAULT_PACO2;
private _co2Gain =
    linearConversion [0, 5, abs _co2Error, 0.3, 1.0, true];
private _co2Drive =
    (linearConversion [30, 50, _previousCyclePaco2, -1200, 1200, true]) * _co2Gain;
private _anaerobicDrive = linearConversion [1.0, 1.6, _anerobicPressure, 0, 3000, true];
private _fatigueDrive = linearConversion [2200, 440, _aceAnReserve, 0, 2400, true];
_demandVentilation =
    (BASE_MIN_VENT * _coNorm)
    + _co2Drive
    + _anaerobicDrive
    + _fatigueDrive;
_demandVentilation = _demandVentilation max MINIMUM_VENTILATION;
if (_paralysis && !_isArrest) then {
    _demandVentilation = BASE_MIN_VENT * _coNorm;
};
if (_isArrest) then {
    _demandVentilation = BASE_MIN_VENT * 0.35;
    _actualVentilation = 1;
};
if (!_airway || (_paralysis && !_ventAttached)) then {
    _actualVentilation = 1;
};
_alveolarDemand = _demandVentilation * (1 - DEAD_SPACE_FRAC);
private _icp = GET_ICP(_unit);
private _map = GET_MAP(_unit);
private _CPP = (_map - _icp) max 0;
private _respDrive = linearConversion [80, 20, _CPP, 1.0, 0.1, true];
_respDrive = _respDrive * (1 - (_opioidDepression * 0.6));
private _bvmDyssyncPrev = _unit getVariable [QGVAR(bvmDyssync), 0];
_respDrive = _respDrive + ((_bvmDyssyncPrev min 0.25) * 0.4);
_respDrive = _respDrive max 0 min 1;
if (_do2Norm < 0.3) then {
    _respDrive = _respDrive * 0.8;
};
if (!_canBreathe) then {
_respDrive = 0;
_patternApplied = true;
};
if (_unit getVariable [QEGVAR(breathing,attachedVent), false]) then {
    _respiratoryRate = (60 / (_unit getVariable [QEGVAR(breathing,ventRate), 5])) max 1;
    _respiratoryDepth = 12;
    _baseTidalVolume = (((GET_KAT_SURFACE_AREA(_unit) * (_respiratoryDepth / 10)) min 0.8) max 0.2);
    _tidalVolume = _baseTidalVolume;
    _actualVentilation = (_tidalVolume * _respiratoryRate) * _bronchospasm;
    _patternApplied = true;
    private _acidRepo = _unit getVariable [QEGVAR(pharma,acidRepo), 1.0];
    private _ventRatio =
        (_respiratoryRate * _respiratoryDepth)
        / (14 * DEFAULT_RESPIRATORY_DEPTH);
    private _sedation =
        (_unit getVariable [QEGVAR(surgery,sedated), 0])
        max (_unit getVariable [QEGVAR(pharma,opioidDepression), 0]);
    private _syncBonus =
        linearConversion [0, 1, _sedation, 0.85, 1.15, true];
    private _repoRestore =
        linearConversion [0.8, 1.8, _ventRatio, 0.015, 0.045, true]
        * _syncBonus;
    _repoRestore =
        _repoRestore
        * linearConversion [6.8, 7.25, _ph, 0.6, 1.0, true];
    _acidRepo = (_acidRepo + _repoRestore) min 1.0;
    private _respFatigue = _unit getVariable [QGVAR(respFatigue), 0];
    _respFatigue =
        (_respFatigue - (0.04 * _syncBonus)) max 0;
    _unit setVariable [QGVAR(respFatigue), _respFatigue, true];
    _unit setVariable [QEGVAR(pharma,acidRepo), _acidRepo, true];
};
if (_bvmMode == BVM_MODE_CONTROL) then {
    _respiratoryRate  = _bvmTargetRR;
    _respiratoryDepth = _bvmTargetDepth;
    _actualVentilation = _bvmVent;
    _patternApplied = true;
    private _acidRepo = _unit getVariable [QEGVAR(pharma,acidRepo), 1.0];
    private _ventRatio =
        (_respiratoryRate * _respiratoryDepth)
        / (14 * DEFAULT_RESPIRATORY_DEPTH);
    private _sedation =
        (_unit getVariable [QEGVAR(surgery,sedated), 0])
        max (_unit getVariable [QEGVAR(pharma,opioidDepression), 0]);
    private _syncBonus =
        linearConversion [0, 1, _sedation, 0.85, 1.15, true];
    private _repoRestore =
        linearConversion [0.8, 1.8, _ventRatio, 0.015, 0.045, true]
        * _syncBonus;
    _repoRestore =
        _repoRestore
        * linearConversion [6.8, 7.25, _ph, 0.6, 1.0, true];
    _acidRepo = (_acidRepo + _repoRestore) min 1.0;
    private _respFatigue = _unit getVariable [QGVAR(respFatigue), 0];
    _respFatigue =
        (_respFatigue - (0.04 * _syncBonus)) max 0;
    _unit setVariable [QGVAR(respFatigue), _respFatigue, true];
    _unit setVariable [QEGVAR(pharma,acidRepo), _acidRepo, true];
};
if (!_patternApplied && (_icp >= 20) && (_icp < 32)) then {
    private _t = CBA_missionTime;
    private _frequency = 1/120;
    private _amplitude = 5;
    private _phase = 0;
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

    if ((random 1) < 0.10) then {
        _respiratoryRate   = 0;
        _respiratoryDepth  = 0;
        _tidalVolume       = 0;
        _actualVentilation = 1;
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
if (!_patternApplied && (_ph <= 7.2) && (_respFatigue < 1.1)) then {
    private _kussScale =
        linearConversion [7.2, 6.8, _ph, 0, 1.0, true];
    _respiratoryRate =
        linearConversion [0, 1, _kussScale, 15, 32, true];
    _respiratoryDepth =
        _baseRespiratoryDepth
        * linearConversion [0, 1, _kussScale, 1.5, 3.2, true];
    private _fatigueGain =
        linearConversion [1.5, 3.2, (_respiratoryDepth / DEFAULT_RESPIRATORY_DEPTH), 0.002, 0.01, true]
        * linearConversion [1.0, 1.2, _anerobicPressure, 0.6, 1.0, true];
    if ((_unit getVariable [QEGVAR(pharma,acidRepo), 1]) < 0.3) then {
        _fatigueGain = _fatigueGain * 1.5;
    };
    _unit setVariable [QGVAR(breathingState), 5, true];
    _respFatigue = (_respFatigue + _fatigueGain) min 1.2;
    
    if (_respFatigue > 0.4) then {
        private _depthPenalty =
            linearConversion [0.4, 1.0, _respFatigue, 1.0, 0.45, true];
        _respiratoryDepth = _respiratoryDepth * _depthPenalty;
    };
    if (_respFatigue > 0.85) then {
    
        _respiratoryRate =
            _respiratoryRate
            * linearConversion [0.85, 1.1, _respFatigue, 1.0, 0.6, true];
        _unit setVariable [QGVAR(breathingState), 6, true];
    };
    _tidalVolume =
    (
        GET_KAT_SURFACE_AREA(_unit)
        * (_respiratoryDepth / 10)
    );  
    _actualVentilation =
        (_tidalVolume * _respiratoryRate)
        * _bronchospasm
        max 1;
    _respDrive = 1;
     // 5 = Kussmaul
    _patternApplied = true;
    TRACE_4(
        "BREATH_KUSSMAUL",
        _anerobicPressure,
        _respiratoryRate,
        _respiratoryDepth,
        _actualVentilation
    );
};
private _respFailure = _unit getVariable [QGVAR(respFailure), RF_NONE];
if (_respFatigue > 0.85 && (_unit getVariable [QEGVAR(pharma,acidRepo), 1]) < 0.25) then {
    _respFailure = RF_IMPENDING;
};

if (_respFatigue > 1.05 && (_unit getVariable [QEGVAR(pharma,acidRepo), 1]) < 0.15) then {
    _respFailure = RF_ESTABLISHED;
};

if (_respFatigue > 1.15 && (_unit getVariable [QEGVAR(pharma,acidRepo), 1]) < 0.05) then {
    _respFailure = RF_COMPLETE;
};
private _hypoxiaStress =
    linearConversion [90, 40, _previousCyclePao2, 0, 1.0, true];

private _hypercapniaStress =
    linearConversion [45, 80, _previousCyclePaco2, 0, 1.2, true];

private _stageMultiplier = switch (_respFailure) do {
    case RF_IMPENDING:   { 0.3 };
    case RF_ESTABLISHED: { 1.0 };
    case RF_COMPLETE:    { 3.0 };
    default              { 0 };
};

_rfBurden = _rfBurden
    + ((_hypoxiaStress + _hypercapniaStress)
       * _stageMultiplier
       * _deltaT);
if ((_respFailure <= RF_IMPENDING) && (_previousCyclePao2 > 75) && (_previousCyclePaco2 < 50)) then {
    _rfBurden = (_rfBurden - (0.15 * _deltaT)) max 0;
};
_unit setVariable [QGVAR(respFailure), _respFailure, true];
if (!_patternApplied && ((!_ventAttached && (_isArrest || !_airway || _paralysis)))) then {
    if (_isArrest && (_bvmMode == BVM_MODE_CONTROL || _unit getVariable [QEGVAR(breathing,attachedVent), false])) then {
        if (_isArrest) then {
            if (_bvmMode == BVM_MODE_CONTROL) then {
                _respiratoryRate  = _bvmTargetRR min 10;
                _respiratoryDepth = _bvmTargetDepth * 0.8;
                _actualVentilation = _bvmVent;
            };
        };
    } else {
        _respiratoryRate  = 0;
        _respiratoryDepth = 0;
        _actualVentilation = 1;
    };
    _respDrive = 0;
    _unit setVariable [QGVAR(bvmDyssync), 0, true];
    _patternApplied = true;
};
if (!_patternApplied) then {
        TRACE_3(
            "BREATH_CTRL_DEMAND",
            _demandVentilation,
            _respDrive,
            _opioidDepression
        );
        _unit setVariable [QGVAR(breathingState), 0, true];
        private _targetRR =
            linearConversion [2400, 10500, _demandVentilation, 8, 35, true];

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
        if (_respFailure == RF_COMPLETE && !_ventAttached) then {
            _respDrive = 0.3;
        };
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
        if (_respiratoryRate < 18 && _respiratoryDepth < (DEFAULT_RESPIRATORY_DEPTH * 1.2)) then {
            _respFatigue = (_respFatigue - 0.01) max 0;
        };
        if (_paralysis) then {
            _respFatigue = (_respFatigue - 0.01) max 0;
        };
        if (_do2Norm < 0.2) then {
            _respFatigue = (_respFatigue + 0.02 * _deltaT) min 1.2;
        };
        _unit setVariable [QGVAR(respFatigue), _respFatigue, true];
        _actualVentilation =
            (_baseVT * _respiratoryRate)
            * _bronchospasm
            max 1;
        if (_bvmMode == BVM_MODE_ASSIST) then { 
            private _patientVent = _actualVentilation;

            private _rrDelta = abs (_respiratoryRate - _bvmTargetRR);
            private _driveFactor = _respDrive;

            private _dyssync =
                linearConversion [0, 15, _rrDelta, 0, DYSSYNC_PENALTY_MAX, true]
                * _driveFactor;
            private _sedation =
                (_unit getVariable [QEGVAR(surgery,sedated), 0])
                max (_unit getVariable [QEGVAR(pharma,opioidDepression), 0]);

            _dyssync = _dyssync * (1 - (_sedation * 0.8));
            _dyssync = _dyssync * (1 - (_providerSkill * 0.6));
            private _bvmVentEffective = _bvmVent * (1 - _dyssync);
            if (_dyssync > 0.25 && (random 1 < 0.25)) then {
                playSound3D [
                    QPATHTOF_SOUND(audio\gasp.ogg),
                    _unit,
                    false,
                    getPosASL _unit,
                    5,
                    1 + random 0.2,
                    6
                ];
            };
            switch (_respFailure) do {        
                case RF_IMPENDING: {
                    _respiratoryDepth = _respiratoryDepth * 0.75;
                    _respiratoryRate  = _respiratoryRate * 1.1;
                    _respDrive = 1;
                    _unit setVariable [QGVAR(breathingState), 7, true];
                };

                case RF_ESTABLISHED: {
                    _respiratoryDepth = _respiratoryDepth * 0.4;
                    _respiratoryRate  = _respiratoryRate * 0.7;
                    _respDrive = 1;
                    _unit setVariable [QGVAR(breathingState), 8, true];
                };

                case RF_COMPLETE: {
                    if (!(_unit getVariable [QEGVAR(breathing,attachedVent), false])
                        && (_bvmMode == BVM_MODE_NONE)) then {
                        
                        if (random 1 < 0.85) then {
                            _respiratoryRate  = 0;
                            _respiratoryDepth = 0;
                            _tidalVolume = 0;
                            _actualVentilation = 1;
                        } else {
                            _respiratoryRate = 1;
                            _respiratoryDepth = DEFAULT_RESPIRATORY_DEPTH * 2.5;
                            _tidalVolume =
                                GET_KAT_SURFACE_AREA(_unit)
                                * (_respiratoryDepth / 10);
                            _actualVentilation =
                                (_tidalVolume * _respiratoryRate) * _bronchospasm;
                            playSound3D [
                                QPATHTOF_SOUND(audio\gasp.ogg),
                                _unit,
                                false,
                                getPosASL _unit,
                                6,
                                1,
                                8
                            ];
                        };
                    };
                    _respDrive = 1;
                    _unit setVariable [QGVAR(breathingState), 9, true];
                };
            };
            _actualVentilation = _patientVent max _bvmVentEffective;
            _unit setVariable [QGVAR(bvmDyssync), _dyssync, true];
        };
        TRACE_3(
            "BREATH_CTRL_VENT",
            _baseVT,
            _respiratoryRate,
            _actualVentilation
        );
    };

_alveolarVent = (_actualVentilation * (1 - DEAD_SPACE_FRAC)) max 1;
private _paco2 = _previousCyclePaco2;

if (EGVAR(breathing,paco2Active)) then {
    TRACE_5("PACO2:ENTRY",
    _previousCyclePaco2,
    _isArrest,
    _ventAttached,
    _airway,
    _paralysis
);

    if ((_isArrest && !_ventAttached)
    || (!_airway)
    || (_paralysis && !_ventAttached)
    )then {
    private _co2Rise =
    linearConversion [0, 1, _anerobicPressure, 0.4, 1.2, true];
    private _tempScale =
        linearConversion [35, 40, _temperature, 0.9, 1.15, true];
    _co2Rise = _co2Rise * _tempScale;
    private _cprPerfusion = 0;
    if (_isArrest && EGVAR(breathing,SpO2_perfusion)) then {
        _cprPerfusion = alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull]);
    };

    private _cprScale = [1, 0.75] select _cprPerfusion;
    _co2Rise = _co2Rise * _cprScale;
    _paco2 = (_previousCyclePaco2 + (_co2Rise * _deltaT)) min 120;
    TRACE_5("PACO2:RISE_ONLY",
    _co2Rise,
    _tempScale,
    _cprScale,
    _deltaT,
    _paco2
);
    } else {
    TRACE_5("PACO2:VENT_PATH",
    _alveolarVent,
    _alveolarDemand,
    _bvmActive,
    _bvmMode,
    _previousCyclePaco2
);
    private _ventRatio = _alveolarVent / (_alveolarDemand max 1);
    private _unconscious = !alive _unit || (_unit getVariable ["ACE_isUnconscious", false]);
    private _opioid = _unit getVariable [QEGVAR(pharma,opioidDepression), 0];
    private _bvmDyssync = _unit getVariable [QGVAR(bvmDyssync), 0];
    if (!_bvmActive) then {
    _bvmDyssync = 0;
    };
    private _cnsSuppression = (_unit getVariable [QEGVAR(surgery,sedated), 0]) max (_opioid);
    private _basal = 1;
    private _basalCO2Prod = 1;

    private _cnsScale =
        linearConversion [0, 1, _cnsSuppression, 1, 0.65, true];
    if (_unconscious) then {
        _basalCO2Prod = 0.8;
    };
    _basalCO2Prod = _basal * _cnsScale;
    private _reserveCO2 =
    linearConversion [2200, 440, _aceAnReserve, 0, 0.8, true];
    private _co2Prod =
    _basalCO2Prod
    + ((_anerobicPressure - 1) max 0)
    + _reserveCO2;
    _co2Prod = _co2Prod * (1 + (_bvmDyssync * 0.3));
    TRACE_5("PACO2:PRODUCTION",
    _cnsSuppression,
    _cnsScale,
    _basalCO2Prod,
    _reserveCO2,
    _co2Prod
    );
    private _ventLP = _unit getVariable [QGVAR(paco2VentLP), _alveolarVent];
    _ventLP = _ventLP + ((_alveolarVent - _ventLP) * 0.12);
    _unit setVariable [QGVAR(paco2VentLP), _ventLP, true];
    private _targetPaco2 =
    DEFAULT_PACO2
    * (_co2Prod)
    / ((_ventLP / 4200) max 0.3);
    _targetPaco2 = _targetPaco2 max 15 min 120;
    if ((_unit getVariable [QGVAR(respFailure), RF_NONE]) >= RF_ESTABLISHED) then {
    _targetPaco2 = _targetPaco2 * 1.25;
    };
    TRACE_4("PACO2:TARGET",
    DEFAULT_PACO2,
    _co2Prod,
    _alveolarVent,
    _targetPaco2
);
    private _deltaPaco2 = (_targetPaco2 - _previousCyclePaco2);
    _deltaPaco2 = _deltaPaco2 max (-PACO2_MAX_CHANGE * _previousCyclePaco2)
                           min ( PACO2_MAX_CHANGE * _previousCyclePaco2);
    
    if (_bvmDyssync > 0) then {
        _deltaPaco2 = _deltaPaco2 + (_bvmDyssync * 2.5);
    };
    if (_isArrest && _bvmMode != BVM_MODE_NONE) then {
        _deltaPaco2 = _deltaPaco2 min 0;
    };
    TRACE_5("PACO2:DELTA",
    _previousCyclePaco2,
    _deltaPaco2,
    _bvmDyssync,
    _isArrest,
    _bvmMode
);
    _paco2 = _previousCyclePaco2 + _deltaPaco2;
    };
};

private _fio2 = switch (true) do {
    case (!_airway): { 0 };
    case (_respiratoryRate == 0): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    case ((_unit getVariable [QEGVAR(breathing,nasalCannula), false]) && ((IN_MED_FACILITY(_unit)) || (IN_MED_VEHICLE(_unit)))): { 0.95 };
    default { DEFAULT_FIO2 };
};

private _pALVo2 =
(
    (_fio2 * (_baroPressure - 47))
    - (_paco2 / RESP_Q)
) max 1;
TRACE_4("Fio2",
    _pALVo2,
    _fio2,
    _baroPressure,
    _paco2
);
private _targetPao2 = _pALVo2 * (1 - _pulmonaryShunt);
if (IN_CRDC_ARRST(_unit)) then {
    private _cprActive =
        alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull]);
    private _perfusion =
        if (_cprActive) then {
            linearConversion [0.6, 1.2, _coNorm, 0.75, 0.95, true]
        } else {
            0.75
        };
    _pao2 =
        (_pALVo2 * _perfusion)
        max 10;
} else {
    private _ventRatio = _alveolarVent / (_alveolarDemand max 1);
    private _ventFrac =
        if (_ventRatio <= 1.0) then {
            linearConversion [0.3, 1.0, _ventRatio, 0.2, 1.0, true]
        } else {
            linearConversion [1.0, 1.6, _ventRatio, 1.0, 0.9, true]
        };
        _pao2 = (_pALVo2 * _ventFrac) max 1;
        TRACE_5("pao2",
        _pALVo2,
        _ventFrac,
        _pao2,
        _alveolarVent,
        _alveolarDemand
        );
    };
private _etco2 = 0;

if (IN_CRDC_ARRST(_unit)) then {
    private _cprActive = alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull]);
    if (_cprActive) then {
        private _cprPerfusion =
            linearConversion [0.6, 1.2, _coNorm, 0.7, 1.1, true];
        _etco2 =
            _paco2
            * _cprPerfusion
            * 0.35;
        _etco2 = _etco2 max 8 min 28;
    } else {
        _etco2 = 0;
    };

} else {
    private _perfEff =
        linearConversion [0.7, 1.4, _co / CO_REF, 0.8, 1.15, true];
    private _bvmDyssync = _unit getVariable [QGVAR(bvmDyssync), 0];
    private _syncEff =
        linearConversion [0, DYSSYNC_PENALTY_MAX, _bvmDyssync, 1.0, 0.75, true];
    _etco2 = _paco2 * 0.875 * _perfEff * _syncEff;
    TRACE_5("etco2",
        _etco2,_co,_paco2,_perfEff,_syncEff);
    _etco2 = _etco2 max 5 min 60;
    if ((_unit getVariable [QEGVAR(circulation,heartRestart), false])) then {
    _etco2 = (_etco2 * 1.35) min 55;
    };
    TRACE_1("etco21",
        _etco2);
    private _bvmDyssync = _unit getVariable [QGVAR(bvmDyssync), 0];
    if (_bvmDyssync > 0) then {
        private _oscAmp =
            linearConversion [0, DYSSYNC_PENALTY_MAX, _bvmDyssync, 0, 3.5, true];

        private _osc =
            (sin (CBA_missionTime * (2.5 + random 0.5))) * _oscAmp;

        _etco2 = (_etco2 + _osc) max 0;
        TRACE_1("etco22",
        _etco2);
    };
    TRACE_1("etco23",
        _etco2);
};

TRACE_3("pao21",
        _pao2,_previousCyclePao2,_arrestPerfusion);
if (_previousCyclePao2 < 55 && _alveolarVent > 3000) then {
    _pulmonaryShunt = (_pulmonaryShunt + (0.00002 * _deltaT));
};
if ((_respiratoryDepth < (DEFAULT_RESPIRATORY_DEPTH * 0.4)) && (_respiratoryRate < 10)) then {
    _pulmonaryShunt = (_pulmonaryShunt + (0.00002 * _deltaT));
};
if (IN_CRDC_ARRST(_unit)) then {
    _pulmonaryShunt = (_pulmonaryShunt + (0.00006 * _deltaT));
};
if (!IN_CRDC_ARRST(_unit) && _alveolarVent > 4000) then {
    _pulmonaryShunt = ((_pulmonaryShunt - (0.0005 * _deltaT)) max 0);
};
_pulmonaryShunt = _pulmonaryShunt min 0.6;
_pao2 = _pao2 * (1 - _pulmonaryShunt);
TRACE_2("pao22",
        _pao2,_pulmonaryShunt);
_pao2 = if (_previousCyclePao2 != _pao2) then { ([ (_previousCyclePao2 - (((PAO2_MAX_CHANGE/10) * EGVAR(breathing,SpO2_MultiplyNegative)) * _deltaT)) , (_previousCyclePao2 + ((PAO2_MAX_CHANGE * EGVAR(breathing,SpO2_MultiplyPositive)) * _deltaT))] select ((_previousCyclePao2 - _pao2) < 0)) } else { _pao2 };
private _baseConst =
    7.4 - log(24 / (0.03 * 39.9));

private _phConst =
    _baseConst - 0.015 * (_temperature - 37);
    
private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];

private _pH =
(_phConst + log(24 / (0.03 * _paco2)))
- (_externalPh / 420)
- ((_aceAnFatigue / 2) / 3);    
TRACE_5("PH",
    _pH,
    _externalPh,
    _paco2,
    _aceAnFatigue,
    _temperature
);
private _p50 = ((25 - (((_pH / DEFAULT_PH) - 1) * 150)) max 15) min 40;
private _o2Sat = ((_pao2^2.7) / (_p50^2.7 + _pao2^2.7)) min 0.999;
private _bvmDyssync = _unit getVariable [QGVAR(bvmDyssync), 0];
if (!_bvmActive) then {
    _bvmDyssync = 0;
};
if (_bvmDyssync > 0) then {
    private _oscAmp = linearConversion [0, DYSSYNC_PENALTY_MAX, _bvmDyssync, 0, 0.04, true];
    private _osc = (sin (CBA_missionTime * 3)) * _oscAmp;
    _o2Sat = ((_o2Sat + _osc) max 0) min 0.999;
};
TRACE_4("BREATH_REST",
    _respiratoryRate,
    _demandVentilation,
    _paco2,
    _pao2
);
private _hemoglobin = linearConversion [0, 2700, GET_BODY_FLUID_ECB(_unit), 0.2, 1.0, true];
private _cao2 = 1.34 * _hemoglobin * (_o2Sat * 100);
private _do2 = _co * _cao2;
private _do2Norm = linearConversion [3.5, 10, _do2, 0, 1, true];
if ((_actualVentilation / _demandVentilation <= 0.35) && !(_unit getVariable ["ACE_isUnconscious", false])) then {
    private _timer = _unit getVariable [QGVAR(airwayTimer), -1];
    if (_timer == -1) then {
        _timer = 45 + random 45;
        _unit setVariable [QGVAR(airwayTimer), _timer, true];
    };
    private _elapsed = _unit getVariable [QGVAR(airwayElapsed), 0];
    private _timeMult = linearConversion [0, 0.35, (_actualVentilation / _demandVentilation), 1.5, 0.75, true];
    _elapsed = _elapsed + (_deltaT * _timeMult);
    if (_elapsed >= _timer) then {
        [_unit, true] call ACEFUNC(medical,setUnconscious);
        _unit setVariable [QGVAR(airwayTimer), -1, true];
        _unit setVariable [QGVAR(airwayElapsed), 0, true];
    } else {
        _unit setVariable [QGVAR(airwayElapsed), _elapsed, true];
    };
} else {
    _unit setVariable [QGVAR(airwayTimer), -1, true];
    _unit setVariable [QGVAR(airwayElapsed), 0, true];
};
_unit setVariable [QGVAR(oxygenDelivery), _do2Norm, true];
_unit setVariable [QGVAR(pulmonaryShunt), _pulmonaryShunt, true];
_unit setVariable [QEGVAR(breathing,breathRate), _respiratoryRate, _syncValues];
_unit setVariable [VAR_RESPIRATORY_DEPTH, _respiratoryDepth, _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
