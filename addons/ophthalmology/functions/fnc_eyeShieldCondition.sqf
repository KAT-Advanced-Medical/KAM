#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Sets condition for the Eye Shield
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_eyeShieldCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
private _eyeInjurySevere = _patient getVariable [QGVAR(eyeInjurySevere), false];

if (_eyeInjurySevere && (({_x != 1} count _eyeInjuries) > 0)) exitWith {
    true
};

false
