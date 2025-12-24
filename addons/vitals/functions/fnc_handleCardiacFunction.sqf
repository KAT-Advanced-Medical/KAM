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

private _icp = GET_ICP(_unit);
private _map = GET_MAP(_unit);
private _actualHeartRate = _hrTarget;
private _painLevel = 0;
private _shockClass = "NONE";
// ================= INPUT TRACE =================
TRACE_4(
    "HR_INPUT",
    GET_HEART_RATE(_unit),
    _map,
    _icp,
    _deltaT
);

// ================= CARDIAC ARREST =================
if IN_CRDC_ARRST(_unit) then {
    if (alive (_unit getVariable [QACEGVAR(medical,CPR_provider), objNull])) then {
        if (_actualHeartRate == 0) then { _syncValue = true };
        _actualHeartRate = random [95, 100, 110];
    } else {
        if (_actualHeartRate != 0) then { _syncValue = true };
        _actualHeartRate = 0;
    };
} else {
    private _defaultHR = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
    private _mapSetpoint = linearConversion [60, 100, _defaultHR, 83, 103, true];
    #define MAP_DEADBAND 3
    #define BARO_KP 0.6
    #define BARO_KI 0.12
    #define INTEGRAL_CLAMP 30
    #define MIN_HR 20
    #define MAX_HR 220


    _painLevel = GET_PAIN_PERCEIVED(_unit);

    private _lastHR =
        GET_HEART_RATE(_unit)
        - _hrTargetAdjustment
        - (10 * _painLevel)
        - (_aceAnFatigue * 40);

    // ================= SV MODEL =================
    private _baselineSV = 0.0810542;
    private _strokeVolume = [_unit] call FUNC(getStrokeVolume);

    private _svMemory =
        _unit getVariable [QGVAR(svMemory), _baselineSV];

    private _svTau = 6;
    _svMemory = _svMemory + ((_strokeVolume - _svMemory) * (_deltaT / _svTau));
    _unit setVariable [QGVAR(svMemory), _svMemory];

    private _effectiveSV = _svMemory max 0.03;

    TRACE_5(
        "SV_MODEL",
        _strokeVolume,
        _svMemory,
        _effectiveSV,
        _svTau,
        _baselineSV
    );
    // ================= BAROREFLEX CORE =================
    private _mapError = (_mapSetpoint) - _map;
    if (abs _mapError < MAP_DEADBAND) then { _mapError = 0 };

    private _mapIntegral =
        _unit getVariable [QGVAR(mapIntegral), 0];

    // --- Integral update ---
    _mapIntegral = _mapIntegral + (_mapError * _deltaT);
    
    // --- Integral leak near setpoint ---
    if (abs _mapError < MAP_DEADBAND) then {
        _mapIntegral = _mapIntegral * 0.85;
    };
    
    // Clamp
    _mapIntegral = (_mapIntegral max -INTEGRAL_CLAMP) min INTEGRAL_CLAMP;
    _unit setVariable [QGVAR(mapIntegral), _mapIntegral];

    private _baroDelta =
        (BARO_KP * _mapError)
    + (BARO_KI * _mapIntegral);

    _modelHR = _defaultHR + _baroDelta;

    TRACE_6(
        "BARO_CORE",
        _map,
        _mapError,
        _mapIntegral,
        _modelHR,
        BARO_KP,
        BARO_KI
    );
    // --- Central autonomic command (resting bias) ---
    private _centralBias = 0;
    
    if (
        _painLevel < 0.05
        && _aceAnFatigue < 0.05
        && abs (_effectiveSV - _baselineSV) < 0.003
    ) then {
        // Suppress baroreflex when near resting conditions
        _centralBias = linearConversion [90, 100, _map, 0, 6, true];
    };
    
    _modelHR = _modelHR + _centralBias;
    
    TRACE_2("CENTRAL_CMD", _centralBias, _modelHR);

    // ================= VAGAL =================
    private _vagalTone = 0;

    if (_painLevel > 0.7) then {
        _vagalTone = linearConversion [0.7, 1.0, _painLevel, 0, 0.35, true];
    };

    private _spo2 = GET_KAT_SPO2(_unit);
    if (_spo2 < 85) then {
        _vagalTone = _vagalTone max
            linearConversion [85, 60, _spo2, 0, 0.5, true];
    };

    TRACE_3(
        "VAGAL",
        _painLevel,
        _spo2,
        _vagalTone
    );

    _modelHR = _modelHR * (1 - _vagalTone);

    // ================= SHOCK =================
    _shockClass = "NONE";
    if (_effectiveSV < 0.06 && _map < 70) then { _shockClass = "COMPENSATED" };
    if (_effectiveSV < 0.04 && _map < 60) then { _shockClass = "DECOMPENSATED" };
    if (_effectiveSV < 0.025) then { _shockClass = "TERMINAL" };

    _unit setVariable [QGVAR(shockClass), _shockClass];

    TRACE_3(
        "SHOCK",
        _shockClass,
        _effectiveSV,
        _map
    );

    switch (_shockClass) do {
        case "DECOMPENSATED": { _modelHR = _modelHR * 1.1 };
        case "TERMINAL":     { _modelHR = _modelHR * 0.6 };
    };

    _modelHR = (_modelHR max MIN_HR) min MAX_HR;

    // ================= SA NODE =================
    private _hrDelta = _modelHR - _lastHR;
    private _rate = 1.2 * _deltaT;

    TRACE_4(
        "SA_NODE",
        _lastHR,
        _modelHR,
        _hrDelta,
        _rate
    );

    if (abs _hrDelta < 0.25) then {
        _actualHeartRate = _lastHR;
    } else {
        _actualHeartRate =
            _lastHR + ((_hrDelta max -_rate) min _rate);
    };

    // ================= REST LOCK =================
   if (
        abs (_map - _mapSetpoint) < 2
        && abs (_effectiveSV - _baselineSV) < 0.003
        && _painLevel < 0.05
        && _aceAnFatigue < 0.05
    ) then {
        _actualHeartRate = _defaultHR;
    
        // Hard reset control states
        _mapIntegral = 0;
        _unit setVariable [QGVAR(mapIntegral), 0];
    
        _unit setVariable [QGVAR(hrMemory), _defaultHR];
    
        TRACE_1("REST_LOCK_HARD", _actualHeartRate);
    
        // Skip smoothing entirely
        _unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];
        _actualHeartRate
    };

    // ================= MODIFIERS =================
    _actualHeartRate =
        _actualHeartRate
        + _hrTargetAdjustment
        + (10 * _painLevel)
        + (_aceAnFatigue * 40);

    _actualHeartRate = (_actualHeartRate max MIN_HR) min MAX_HR;
};
// ================= HR SMOOTHING =================
private _hrMem =
    _unit getVariable [QGVAR(hrMemory), _actualHeartRate];

// Time constant (seconds)
private _hrTau = 3.5;

// Faster response in shock or pain
if (_shockClass != "NONE" || _painLevel > 0.4) then {
    _hrTau = 1.8;
};

// First-order low-pass filter
_hrMem =
    _hrMem
    + ((_actualHeartRate - _hrMem) * (_deltaT / _hrTau));

_unit setVariable [QGVAR(hrMemory), _hrMem];

// Replace output
_actualHeartRate = _hrMem;
// ================= FINAL TRACE =================
TRACE_3(
    "HR_FINAL",
    _actualHeartRate,
    _map,
    GET_BLOOD_VOLUME_LITERS(_unit)
);

_unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];
_actualHeartRate
