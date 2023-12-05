#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle cancelling recovery position if patient is in one
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Hint is delayed? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, false] call kat_airway_fnc_handleRecoveryPosition;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_delayed", false]];

if (_patient getVariable [QGVAR(recovery), false]) then {
    [_medic, _patient, _delayed] call FUNC(treatmentAdvanced_CancelRecoveryPosition);
};