#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle cancelling recovery position if patient is in one
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, false] call kat_airway_fnc_handleRecoveryPosition;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (_patient getVariable [QGVAR(recovery), false]) then {
    [_medic, _patient] call FUNC(treatmentAdvanced_CancelRecoveryPosition);
};