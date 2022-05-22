#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if guedel or larynx was placed before or any fractures are present
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 * 
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * call kat_airway_fnc_checkRecovery;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = true;

//check if patient has inserted larynx or guedeltube
if (_patient getVariable [QGVAR(airway_item), ""] in ["larynx","guedel"]) then {
    _return = false;
};

_return