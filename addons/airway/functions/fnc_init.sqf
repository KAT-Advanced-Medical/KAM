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

params ["_unit"];

_unit setVariable [QGVAR(obstruction), false, true]; // tonque
_unit setVariable [QGVAR(occluded), false, true]; // blood
_unit setVariable [QGVAR(collapsed), false, true]; // pneumothorax
_unit setVariable [QGVAR(airway), [false, ""], true];
_unit setVariable [QGVAR(headtilt), false, true];
_unit setVariable [QGVAR(startTime), 0, true];
