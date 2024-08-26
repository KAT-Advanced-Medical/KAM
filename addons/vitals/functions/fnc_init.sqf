#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_vitals_fnc_init
 *
 * Public: No
 */

params ["_patient"];

if (!(isPlayer _unit) && GVAR(simpleMedical)) then { _patient setVariable [QGVAR(simpleMedical), true, true] };