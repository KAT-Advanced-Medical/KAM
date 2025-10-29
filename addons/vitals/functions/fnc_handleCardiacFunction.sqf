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

#define HEART_RATE_CO2_MULTIPLIER 60
#define CO2_TO_DEMAND_DIVISOR 37894.7367424
#define BLOOD_VOLUME_TO_STROKE_DIVISOR 3789.47371


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
    private _painLevel = GET_PAIN_PERCEIVED(_unit);
    private _defaultstrokeVolume = [_unit] call FUNC(getDefaultStrokeVolume);
    // Adjustments and Pain Levels are taken off of last cycle HR to prevent any spiraling vitials
    private _lastCycleHeartRate = GET_HEART_RATE(_unit) - _hrTargetAdjustment - (10 * _painLevel) - (_aceAnFatigue * 40);
    if (GET_HEART_RATE(_unit) == 0) then {
        _lastCycleHeartRate = 40;
    };
    private _lastCycleCO2 = _lastCycleHeartRate * HEART_RATE_CO2_MULTIPLIER;
    private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
    private _demandReturn = _lastCycleCO2 / CO2_TO_DEMAND_DIVISOR;
    private _strokeVolume = [_unit] call FUNC(getStrokeVolume);

    private _strokeVolumeDifference = [_strokeVolume / (_defaultstrokeVolume * 0.66), _defaultstrokeVolume / _strokeVolume ] select (_defaultstrokeVolume / _strokeVolume < 1.22);
    private _volumeSupportHR = _defaultHeartRate * _strokeVolumeDifference;

    // As HR increases, pressure is taken off decreasing stroke volume. However, this effect decreases at higher heart rates and lower SVs
    TRACE_7("HR1",_lastCycleHeartRate,_lastCycleCO2,_demandReturn,_strokeVolume,_strokeVolumeDifference,_volumeSupportHR,_hrTargetAdjustment);
    // Model HR driven by demandReturn divided by stroke volume with pressure applied by volume shortage. 40 point baseline applied to keep movements more stable
    private _modelHeartRate = 40 + ((_demandReturn / _strokeVolume) * ((0.004407 * _defaultHeartRate) * _defaultHeartRate)) + (_volumeSupportHR - _defaultHeartRate);
    private _modelHeartRate = (_modelHeartRate * 0.9) + (_defaultHeartRate * 0.1);
    TRACE_5("HR2",_modelHeartRate,_demandReturn,_strokeVolume,_defaultHeartRate,_volumeSupportHR);
    // Actual Heart Rate increases stepwise under the target model
    _actualHeartRate = switch (true) do {
        case (_modelHeartRate > _lastCycleHeartRate): { (_lastCycleHeartRate + (1 * _deltaT)) min _modelHeartRate }; 
        case (_modelHeartRate < _lastCycleHeartRate): { (_lastCycleHeartRate - (1 * _deltaT)) max _modelHeartRate }; 
        default { _modelHeartRate };
    };

    // All additional adjustments are added back 
    _actualHeartRate = _actualHeartRate + _hrTargetAdjustment + (10 * _painLevel) + (_aceAnFatigue * 40);
};

_unit setVariable [VAR_HEART_RATE, _actualHeartRate, _syncValue];

_actualHeartRate
