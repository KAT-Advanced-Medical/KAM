#include "..\script_component.hpp"
/*
 * Author: Glowbal, Mazinski
 * Update the heart rate and cardiac return
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Heart Rate Adjustments <NUMBER>
 * 2: Heart Rate Target <NUMBER>
 * 3: Blood Volume <NUMBER>
 * 4: Time since last update <NUMBER>
 * 5: Sync value? <BOOL>
 *
 * ReturnValue:
 * Current Heart Rate <NUMBER>
 *
 * Example:
 * [player, 0, 80, 6, 1, false] call kat_misc_handleCardiacFunction;
 *
 * Public: No
 */

params ["_unit", "_hrTargetAdjustment", "_hrTarget", "_bloodVolume", "_deltaT", "_syncValue"];

private _actualHeartRate = _hrTarget;
private _actualReturn = 0;

if IN_CRDC_ARRST(_unit) then {
    if (alive (_unit getVariable [QEGVAR(medical,CPR_provider), objNull])) then {
        if (_actualHeartRate == 0) then { _syncValue = true }; // always sync on large change
        _actualHeartRate = random [25, 30, 35];
    } else {
        if (_actualHeartRate != 0) then { _syncValue = true }; // always sync on large change
        _actualHeartRate = 0
    };
} else {
    private _painLevel = GET_PAIN_PERCEIVED(_unit);

    // Adjustments and Pain Levels are taken off of last cycle HR to prevent any spiraling vitials
    private _lastCycleHeartRate = GET_HEART_RATE(_unit) - _hrTargetAdjustment - (10 * _painLevel);
    private _lastCycleCO2 = _lastCycleHeartRate * HEART_RATE_CO2_MULTIPLIER;
    private _demandReturn = _lastCycleCO2 / 37894.7367424;
    private _strokeVolume = (_bloodVolume / 3789.47371);

    // As HR increases, pressure is taken off decreasing stroke volume. However, this effect decreases at higher heart rates and lower SVs
    private _strokeVolumeDifference = [ _strokeVolume / (DEFAULT_STROKE_VOLUME * 0.66) , DEFAULT_STROKE_VOLUME / _strokeVolume ] select (DEFAULT_STROKE_VOLUME / _strokeVolume < 1.22);
    private _volumeSupportHR = 80 * _strokeVolumeDifference;
    _strokeVolume = _strokeVolume * _strokeVolumeDifference;

    // Model HR driven by demandReturn divided by stroke volume with pressure applied by volume shortage. 40 point baseline applied to keep movements more stable
    private _modelHeartRate = 40 + ((_demandReturn / _strokeVolume) / 2) + (_volumeSupportHR - 80);

    // Actual Heart Rate increases stepwise under the target model
    _actualHeartRate = switch (true) do {
        case (_modelHeartRate > _lastCycleHeartRate): { (_lastCycleHeartRate + (1 * _deltaT)) min _modelHeartRate }; 
        case (_modelHeartRate < _lastCycleHeartRate): { (_lastCycleHeartRate - (1 * _deltaT)) max _modelHeartRate }; 
        default { _modelHeartRate };
    };

    // All additional adjustments are added back 
    _actualHeartRate = _actualHeartRate + _hrTargetAdjustment + (10 * _painLevel);
};

_unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];

_actualHeartRate