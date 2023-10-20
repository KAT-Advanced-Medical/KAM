#include "script_component.hpp"
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
 * [player] call kat_airway_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

_unit setVariable [QGVAR(obstruction), false, true];
_unit setVariable [QGVAR(occluded), false, true];
_unit setVariable [QGVAR(airway), false, true];
_unit setVariable [QGVAR(overstretch), false, true];
_unit setVariable [QGVAR(recovery), false, true];
_unit setVariable [QGVAR(airway_item), "", true];
_unit setVariable [QGVAR(clearedTime), 0, true];
KAT_forceWakeup = false;