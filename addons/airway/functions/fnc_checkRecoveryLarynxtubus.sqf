#include "script_component.hpp"
/*
 * Author: Miss Heda, copied from MiszczuZPolski
 * Checks if larynx was placed before
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_checkRecoveryLarynxtubus;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = false;

//check if patient has inserted larynx
if ((_patient getVariable [QGVAR(airway_item), ""] in ["Larynxtubus"]) || !(isNull objectParent _patient)) then {
    _return = true;
};

_return