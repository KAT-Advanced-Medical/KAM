#include "script_component.hpp"
/*
 * Author: Blue
 * Check if patient has any kind of BVM
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 
 * Return Value:
 * Has BVM <BOOLEAN>
 *
 * Example:
 * [patient] call kat_breathing_fnc_hasBVM;
 *
 * Public: No
 */

params ["_patient"];

_patient getVariable [QGVAR(BVM), false] || _patient getVariable [QGVAR(pocketBVM), false];