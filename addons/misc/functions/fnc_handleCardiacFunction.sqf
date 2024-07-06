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

params ["_unit", "_hrTargetAdjustment", "_hrTarget", "_deltaT", "_syncValue"];

private _heartRate = _hrTarget;

if IN_CRDC_ARRST(_unit) then {
    if (alive (_unit getVariable [QEGVAR(medical,CPR_provider), objNull])) then {
        if (_heartRate == 0) then { _syncValue = true }; // always sync on large change
        _heartRate = random [25, 30, 35];
    } else {
        if (_heartRate != 0) then { _syncValue = true }; // always sync on large change
        _heartRate = 0
    };
} else {
    private _painLevel = GET_PAIN_PERCEIVED(_unit);
    _heartRate = (_hrTarget + (_deltaT * _hrTargetAdjustment) + (10 * _painLevel));
};

_unit setVariable [VAR_HEART_RATE, round(_heartRate), _syncValue];

_heartRate