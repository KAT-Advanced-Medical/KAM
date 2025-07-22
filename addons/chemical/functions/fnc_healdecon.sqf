#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * heal contamiation
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_chemical_healdecon;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(Contaminated), false, true];
_patient setVariable [QGVAR(contaminatedBody), false, true];
_patient setVariable [QGVAR(contaminatedHead), false, true];
