#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handles the placement of the eye shield.
 *
 * Return Value:
 * None
 *
 * Public: No
 *
 */

params ["_medic", "_patient"];

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
private _eyeInjurySevere = _patient setVariable [QGVAR(eyeInjurySevere), false, true];

if (_eyeInjurySevere && (({_x = 1} count _eyeInjuries) == 1)) exitWith {
	true
};

false
