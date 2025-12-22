#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
/*
 * Author: Glowbal, Mazinski
 * Update heart rate
 
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Heart Rate Adjustments <NUMBER>
 * 2: Heart Rate Target <NUMBER>
 * 3: Blood Volume <NUMBER>
 * 4: ACE Fatigue <NUMBER>
 * 5: Time since last update <NUMBER>
 * 6: Sync value? <BOOL>
 *
 * ReturnValue:
 * Current Heart Rate <NUMBER>
 *
 * Example:
 * [player, 0, 80, 6, 0.1, 1, false] call kat_vitals_handleCardiacFunction;
 *
 * Public: No
 */

params ["_unit", "_hrTargetAdjustment", "_hrTarget", "_bloodVolume", "_aceAnFatigue", "_deltaT", "_syncValue"];

#define BASELINE_CO 0.1172072   // Your targetCO value
#define MIN_HR 20
#define MAX_HR 240
#define HEART_RATE_CO2_MULTIPLIER 60 
#define CO2_TO_DEMAND_DIVISOR 37894.7367424

private _icp = GET_ICP(_unit);
private _map = GET_MAP(_unit);
private _actualHeartRate = _hrTarget;
private _actualReturn = 0;

if IN_CRDC_ARRST(_unit) then {
    if (alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull])) then {
        if (_actualHeartRate == 0) then { _syncValue = true }; // always sync on large change
        _actualHeartRate = random [100, 110, 120];
    } else {
        if (_actualHeartRate != 0) then { _syncValue = true }; // always sync on large change
        _actualHeartRate = 0
    };
} else {
// --- Constants ---

private _defaultHR = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
private _painLevel = GET_PAIN_PERCEIVED(_unit);

// Remove modifiers from last cycle to avoid spiral
private _lastHR =
    GET_HEART_RATE(_unit)
    - _hrTargetAdjustment
    - (10 * _painLevel)
    - (_aceAnFatigue * 40);

if (_unit getVariable [QEGVAR(circulation,heartRestart), false]) then {
    _lastHR = floor (random [40, 50, 60]);
};

// --- Metabolic Demand (dimensionless multiplier) ---
private _co2Production = _lastHR * HEART_RATE_CO2_MULTIPLIER;
private _metabolicDemand =
    0.5 * ((_lastHR * HEART_RATE_CO2_MULTIPLIER) / CO2_TO_DEMAND_DIVISOR)
  + 0.5 * (_aceAnFatigue + _painLevel);
_metabolicDemand = _metabolicDemand - 0.063;
_metabolicDemand = _metabolicDemand max 0;
// --- Target Cardiac Output ---
private _targetCO = BASELINE_CO * (1 + _metabolicDemand);
private _map = GET_MAP(_unit);

// Scale target CO down as MAP falls
private _coScale =
    linearConversion [80, 50, _map, 1.0, 0.6, true];

_targetCO = BASELINE_CO * _coScale;
// --- Stroke Volume (your function) ---
private _strokeVolume = [_unit] call FUNC(getStrokeVolume);

// --- Core physiological relationship ---
// --- Core physiological relationship (ratio-based) ---
private _baselineSV = 0.0862038;
private _baselineHR = _defaultHR;

// HR scales with CO demand and inversely with SV
private _modelHR =
    _baselineHR
    * (_targetCO / BASELINE_CO)
    * (_baselineSV / (_strokeVolume max 0.02));

// --- Autonomic damping (vagal tone) ---
_modelHR = (_modelHR * 0.85) + (_defaultHR * 0.15);

// --- Vagal Reflex ---
private _vagalTone = 0;

// Pain-induced vagal response (vasovagal)
if (_painLevel > 0.7) then {
    _vagalTone = linearConversion [0.7, 1.0, _painLevel, 0, 0.35, true];
};

// Hypoxia-induced vagal bradycardia
private _spo2 = _unit getVariable [QEGVAR(breathing,SpO2), 100];
if (_spo2 < 85) then {
    _vagalTone = _vagalTone max linearConversion [85, 60, _spo2, 0, 0.5, true];
};

// Apply vagal suppression
_modelHR = _modelHR * (1 - _vagalTone);

private _shockClass = "NONE";

if (_strokeVolume < 0.06 && _modelHR > 100) then {
    _shockClass = "COMPENSATED";
};
if (_strokeVolume < 0.04 && _modelHR > 130) then {
    _shockClass = "DECOMPENSATED";
};
if (_strokeVolume < 0.025) then {
    _shockClass = "TERMINAL";
};

_unit setVariable [QEGVAR(circulation,shockClass), _shockClass];

switch (_shockClass) do {
    case "COMPENSATED": {
        // nothing extra
    };
    case "DECOMPENSATED": {
        _modelHR = _modelHR * 1.1; // catecholamine surge
    };
    case "TERMINAL": {
        _modelHR = _modelHR * 0.6; // myocardial failure
    };
};
private _cushing = [_unit] call FUNC(getCushings);
if (_cushing > 0) then {
    // Max ~40% HR reduction at full Cushing
    private _bradyMult = linearConversion [0, 1, _cushing, 1.0, 0.6, true];
    _modelHR = _modelHR * _bradyMult;

    // Clamp — brainstem reflex bradycardia but not zero
    _modelHR = _modelHR max 30;
};
// --- Physiological limits ---
_modelHR = _modelHR max MIN_HR min MAX_HR;

private _tachyDuration =
    _unit getVariable [QEGVAR(circulation,tachyDuration), 0];

if (_modelHR > 140 && _strokeVolume < 0.04) then {
    _tachyDuration = _tachyDuration + _deltaT;
} else {
    _tachyDuration = _tachyDuration max 0 - (2 * _deltaT);
};

_unit setVariable [QEGVAR(circulation,tachyDuration), _tachyDuration];

// Collapse trigger
if (_tachyDuration > 30) then {
    _modelHR = _modelHR * linearConversion [30, 45, _tachyDuration, 1, 0.3, true];
};
_modelHR = _lastHR + (((_modelHR - _lastHR) min 5) max -5);
TRACE_6(
    "HR_MODEL",
    _modelHR,
    _strokeVolume,
    _targetCO,
    _metabolicDemand,
    _lastHR,
    _defaultHR
);

// --- SA-node inertia ---
_actualHeartRate = switch (true) do {
    case (_modelHR > _lastHR): { (_lastHR + (1.0 * _deltaT)) min _modelHR };
    case (_modelHR < _lastHR): { (_lastHR - (1.4 * _deltaT)) max _modelHR };
    default { _modelHR };
};

// --- Reapply modifiers ---
_actualHeartRate =
    _actualHeartRate
    + _hrTargetAdjustment
    + (10 * _painLevel)
    + (_aceAnFatigue * 40);

// Final clamp
_actualHeartRate = (_actualHeartRate max MIN_HR) min MAX_HR;
};
_unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];
_actualHeartRate