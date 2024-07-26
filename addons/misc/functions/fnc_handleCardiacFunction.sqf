#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Update the heart rate
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Heart Rate Adjustments <NUMBER>
 * 2: Heart Rate Target <NUMBER>
 * 3: Time since last update <NUMBER>
 * 4: Sync value? <BOOL>
 *
 * ReturnValue:
 * Current Heart Rate <NUMBER>
 *
 * Example:
 * [player, 0, 80, 1, false] call ace_medical_vitals_fnc_updateHeartRate
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
    private _lastCycleCO2 = _lastCycleHeartRate * 60;
    private _demandReturn = _lastCycleCO2 / 37894.7367424;
    private _strokeVolume = ((_bloodVolume select 0) / 3789.47371);

    // As HR increases, pressure is taken off decreasing stroke volume. However, this effect decreases at higher heart rates and lower SVs
    private _strokeVolumeDifference = [ ((((_strokeVolume) max 0.0001) / 0.001055555549) max 1) , 0.001583333323 / _strokeVolume ] select (0.001583333323 / _strokeVolume < 1.22);
    private _volumeSupportHR = 80 * _strokeVolumeDifference;
    _strokeVolume = _strokeVolume * _strokeVolumeDifference;

    private _modelHeartRate = 40 + ((_demandReturn / _strokeVolume) / 2) + (_volumeSupportHR - 80);

    // Actual Heart Rate increases stepwise under the target model
    _actualHeartRate = switch (true) do {
        case (_modelHeartRate > _lastCycleHeartRate): { (_lastCycleHeartRate + (1 * _deltaT)) min _modelHeartRate }; 
        case (_modelHeartRate < _lastCycleHeartRate): { (_lastCycleHeartRate - (1 * _deltaT)) max _modelHeartRate }; 
        default { _modelHeartRate };
    };

    // All additional adjustments are added back 
    _actualHeartRate = _actualHeartRate + _hrTargetAdjustment + (10 * _painLevel);

    _actualReturn = _strokeVolume * _actualHeartRate;
};

_unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];

[_actualHeartRate, _actualReturn]