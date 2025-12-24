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
private _etco2 = 15;
private _pao2 = 90;
private _patternApplied = false;
private _previousCyclePaco2 = (_bloodGas select 0);
private _previousCyclePao2  = (_bloodGas select 1);
private _baseRespiratoryDepth = DEFAULT_RESPIRATORY_DEPTH;
private _bronchospasm = _unit getVariable [QEGVAR(breathing,bronchospasm), 1];
private _airway = HAS_AIRWAY(_unit);
private _paralysis = (_unit getVariable [QEGVAR(breathing,paralysis), 0] > 0.1);

///////////////////////////////////////////////////////////////////////////////
// AIRWAY FAILURE PFH (UNCHANGED)
///////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
// CARDIAC ARREST / NO AIRWAY
///////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
// METABOLIC VENTILATION DEMAND (UNCHANGED STRUCTURE)
///////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////
// CENTRAL DRIVE & OPIOIDS
///////////////////////////////////////////////////////////////////////////////

    private _icp = GET_ICP(_unit);
    private _map = GET_MAP(_unit);
    private _CPP = (_map - _icp) max 0;

    private _respDrive = linearConversion [80, 20, _CPP, 1.0, 0.1, true];
    _respDrive = _respDrive * (1 - (_opioidDepression * 0.6));
    _respDrive = _respDrive max 0 min 1;

///////////////////////////////////////////////////////////////////////////////
// NON-NORMAL BREATHING PATTERNS (UNCHANGED)
///////////////////////////////////////////////////////////////////////////////

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

        ///////////////////////////////////////////////////////////////////////////
        // CHEYNE–STOKES: CO2-DELAY DRIVEN (NO TIME BASE)
        ///////////////////////////////////////////////////////////////////////////
    
        // --- CO2 sensing delay (circulatory delay)
        private _delayTau = linearConversion [20, 32, _icp, 10, 25, true];
        private _co2Mem = _unit getVariable [QEGVAR(breathing,csCO2Memory), _previousCyclePaco2];
    
        _co2Mem = _co2Mem + ((_previousCyclePaco2 - _co2Mem) * (_deltaT / _delayTau));
        _unit setVariable [QEGVAR(breathing,csCO2Memory), _co2Mem];
    
        // --- Central controller (overshoot-prone)
        private _co2Error = _co2Mem - DEFAULT_PACO2;
    
        // Gain increases as CPP falls
        private _csGain = linearConversion [70, 30, _CPP, 0.4, 1.4, true];
    
        private _drive = (_co2Error / 10) * _csGain;
    
        // --- Clamp drive
        _drive = _drive max -1.2 min 1.5;
    
        if (_drive <= -0.3) then {
            // Apnea phase
            _respiratoryRate  = 0;
            _respiratoryDepth = 0;
            _tidalVolume      = 0;
            _actualVentilation = 1;
    
        } else {
            // Crescendo–decrescendo phase
            private _env = linearConversion [-0.3, 1.5, _drive, 0.2, 1.8, true];
    
            _respiratoryRate  = 14 * _env;
            _respiratoryDepth = 10 * _env;
    
            _tidalVolume =
                GET_KAT_SURFACE_AREA(_unit)
                * (_respiratoryDepth / 10);
    
            _actualVentilation =
                (_tidalVolume * _respiratoryRate)
                * _bronchospasm;
        };
    
        // Apply residual central drive suppression
        _respiratoryRate  = _respiratoryRate  * _respDrive;
        _respiratoryDepth = _respiratoryDepth * (_respDrive max MINIMUM_DEPTH);
        _actualVentilation = _actualVentilation * _respDrive;
    
        _patternApplied = true;
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
        _respDrive = _respDrive max 0 min 1;
        _respiratoryRate  = _respiratoryRate  * _respDrive;
        _respiratoryDepth = _respiratoryDepth * (_respDrive max MINIMUM_DEPTH);
        _actualVentilation = _actualVentilation * _respDrive;
        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 2, true];
    };

        if (!_patternApplied && (_icp >= 32) && (_icp < 38)) then {

        ///////////////////////////////////////////////////////////////////////////
        // BIOT BREATHING — CO2-CHAOTIC (MEDULLARY INSTABILITY)
        ///////////////////////////////////////////////////////////////////////////

        // --- CO2 instability signal (second derivative proxy)
        private _co2Vel =
            (_previousCyclePaco2 - (_unit getVariable [QEGVAR(breathing,lastPaco2), _previousCyclePaco2]))
            / (_deltaT max 0.01);

        _unit setVariable [QEGVAR(breathing,lastPaco2), _previousCyclePaco2];

        private _co2Accel =
            (_co2Vel - (_unit getVariable [QEGVAR(breathing,lastPaco2Vel), 0]))
            / (_deltaT max 0.01);

        _unit setVariable [QEGVAR(breathing,lastPaco2Vel), _co2Vel];

        // --- Instability grows with ICP and falling CPP
        private _instability =
            (abs _co2Accel)
            * linearConversion [32, 38, _icp, 0.8, 1.8, true]
            * linearConversion [70, 30, _CPP, 0.7, 1.4, true];

        // --- Apnea threshold
        if (_instability > 1.2) then {

            // Apnea
            _respiratoryRate  = 0;
            _respiratoryDepth = 0;
            _tidalVolume      = 0;
            _actualVentilation = 1;

        } else {

            // Erratic breathing (non-periodic)
            private _env = linearConversion [0, 1.2, _instability, 1.2, 0.3, true];

            _respiratoryRate  = 8  * _env;
            _respiratoryDepth = 10 * _env;

            _tidalVolume =
                GET_KAT_SURFACE_AREA(_unit)
                * (_respiratoryDepth / 10);

            _actualVentilation =
                (_tidalVolume * _respiratoryRate)
                * _bronchospasm;
        };

        // Residual central drive
        _respiratoryRate  = _respiratoryRate  * _respDrive;
        _respiratoryDepth = _respiratoryDepth * (_respDrive max MINIMUM_DEPTH);
        _actualVentilation = _actualVentilation * _respDrive;

        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 2, true];
    };

    if (!_patternApplied && (_icp >= 45)) then {
        
        ///////////////////////////////////////////////////////////////////////////
        // AGONAL RESPIRATION — MEDULLARY HYPOXIA DRIVEN
        ///////////////////////////////////////////////////////////////////////////
    
        // --- Medullary hypoxia index
        private _medullaO2 =
            _previousCyclePao2
            * linearConversion [70, 20, _CPP, 1.0, 0.4, true];
    
        private _hypoxiaIndex =
            linearConversion [30, 10, _medullaO2, 0, 1.5, true];
    
        // --- Gasp trigger threshold
        private _gaspTrigger =
            _unit getVariable [QEGVAR(breathing,gaspTrigger), 0];
    
        _gaspTrigger = _gaspTrigger + (_hypoxiaIndex * _deltaT);
        _unit setVariable [QEGVAR(breathing,gaspTrigger), _gaspTrigger];
    
        if (_gaspTrigger >= 1.0) then {
        
            // GASP
            _unit setVariable [QEGVAR(breathing,gaspTrigger), 0];
    
            _respiratoryRate  = 1;
            _respiratoryDepth = _baseRespiratoryDepth * (2.5 + _hypoxiaIndex);
    
            _tidalVolume =
                GET_KAT_SURFACE_AREA(_unit)
                * (_respiratoryDepth / 10);
    
            _actualVentilation =
                (_tidalVolume * _respiratoryRate)
                * _bronchospasm;
    
            playSound3D [
                QPATHTOF_SOUND(audio\gasp.ogg),
                _unit,
                false,
                getPosASL _unit,
                6, 1, 8
            ];
    
        } else {
        
            // Apnea between gasps
            _respiratoryRate  = 0;
            _respiratoryDepth = 0;
            _tidalVolume      = 0;
            _actualVentilation = 1;
        };
    
        _patternApplied = true;
        _unit setVariable [QGVAR(breathingState), 4, true];
    };
if (!_patternApplied) then {

        ///////////////////////////////////////////////////////////////////////////
        // TRACE: DEMAND → TARGET RR
        ///////////////////////////////////////////////////////////////////////////
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

        ///////////////////////////////////////////////////////////////////////////
        // TRACE: TARGET RR
        ///////////////////////////////////////////////////////////////////////////
        TRACE_2(
            "BREATH_CTRL_TARGET_RR",
            _targetRR,
            _respiratoryRateMult
        );

        private _rrMem = _unit getVariable [QEGVAR(breathing,rrMemory), _targetRR];
        _rrMem = _rrMem + ((_targetRR - _rrMem) * (_deltaT / 2.5));
        _unit setVariable [QEGVAR(breathing,rrMemory), _rrMem];

        _respiratoryRate = _rrMem * _respDrive;

        ///////////////////////////////////////////////////////////////////////////
        // TRACE: RR MEMORY & OUTPUT
        ///////////////////////////////////////////////////////////////////////////
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

        ///////////////////////////////////////////////////////////////////////////
        // TRACE: BASE VT
        ///////////////////////////////////////////////////////////////////////////
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

            ///////////////////////////////////////////////////////////////////////////
            // TRACE: VT TACHYPNEA SCALING
            ///////////////////////////////////////////////////////////////////////////
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

        ///////////////////////////////////////////////////////////////////////////
        // TRACE: ACTUAL VENTILATION
        ///////////////////////////////////////////////////////////////////////////
        TRACE_3(
            "BREATH_CTRL_VENT",
            _baseVT,
            _respiratoryRate,
            _actualVentilation
        );
    };
};

///////////////////////////////////////////////////////////////////////////////
// >>> REALISM FIX: ALVEOLAR VENTILATION
///////////////////////////////////////////////////////////////////////////////
_alveolarVent = (_actualVentilation * (1 - DEAD_SPACE_FRAC)) max 1;

///////////////////////////////////////////////////////////////////////////////
// >>> REALISM FIX: PaCO2 DYNAMICS
///////////////////////////////////////////////////////////////////////////////
private _paco2 = _previousCyclePaco2;

if (EGVAR(breathing,paco2Active)) then {
    private _ventRatio = _alveolarVent / (_alveolarDemand max 1);
    // --- Consciousness
    private _unconscious = !alive _unit || (_unit getVariable ["ACE_isUnconscious", false]);

    // --- Sedation / opioids (0–1)
    private _opioid = _unit getVariable [QEGVAR(pharma,opioidDepression), 0];

    // --- Anesthesia proxy (ACE fatigue used as CNS suppression)
    private _cnsSuppression = (_unit getVariable [QEGVAR(surgery,sedated), 0])
        max (_opioid);

    // --- Awake baseline
    private _basal = 1.0;

    // --- CNS suppression scaling
    private _cnsScale =
        linearConversion [0, 1, _cnsSuppression, 1.0, 0.65, true];


    // --- Unconscious override
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

///////////////////////////////////////////////////////////////////////////////
// >>> REALISM FIX: ETCO2
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// OXYGENATION
///////////////////////////////////////////////////////////////////////////////
private _fio2 = switch (true) do {
    case (!_airway): { 0 };
    case (_respiratoryRate == 0): { 0 };
    case (_unit getVariable [QEGVAR(breathing,oxygenTankConnected), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,attachedVent), false]): { 1 };
    case (_unit getVariable [QEGVAR(breathing,oxygenMaskActive), false]): { 0.95 };
    default { DEFAULT_FIO2 };
};

///////////////////////////////////////////////////////////////////////////////
// >>> REALISM FIX: ALVEOLAR GAS EQUATION
///////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
// pH & SATURATION (UNCHANGED)
///////////////////////////////////////////////////////////////////////////////
private _phConst = ((-0.00006653 * (_temperature ^ 2)) - (0.03268 * _temperature) + 7.4);
private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];

private _pH =
(_phConst + log(24 / (0.03 * _paco2)))
- ((_externalPh max 0) / 60)
- ((_aceAnFatigue / 2) / 3);

private _p50 = ((25 - (((_pH / DEFAULT_PH) - 1) * 150)) max 15) min 40;
private _o2Sat = ((_pao2^2.7) / (_p50^2.7 + _pao2^2.7)) min 0.999;
TRACE_4("BREATH_REST",
    _respiratoryRate,
    _demandVentilation,
    _paco2,
    _pao2
);
///////////////////////////////////////////////////////////////////////////////
// OUTPUT
///////////////////////////////////////////////////////////////////////////////
_unit setVariable [QEGVAR(breathing,breathRate), _respiratoryRate, _syncValues];
_unit setVariable [VAR_RESPIRATORY_DEPTH, _respiratoryDepth, _syncValues];
_unit setVariable [VAR_BLOOD_GAS, [_paco2, _pao2, _o2Sat, 24, _pH, _etco2], _syncValues];

_o2Sat * 100
