#include "script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_breathing_fnc_init
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(status), 100, true];
_unit setVariable [QGVAR(pulseoximeter), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(o2), false, true];
