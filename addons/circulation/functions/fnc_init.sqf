#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(cprCount), 2, true];

// Currently four HT conditions: Tamponade, Tension, Hypoxia, and Hydrogen (Ions)
_unit setVariable [QGVAR(ht), [], true];

_unit setVariable [QGVAR(effusion), 0, true];

