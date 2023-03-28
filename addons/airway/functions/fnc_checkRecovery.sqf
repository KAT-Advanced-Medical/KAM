#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if guedel or larynx was placed before
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_checkRecovery;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = true;

//check if patient has inserted larynx or guedeltube
if ((_patient getVariable [QGVAR(airway_item), ""] in ["Larynxtubus","Guedeltubus"]) || !(isNull objectParent _patient)) then {
    _return = false;
};

_return
