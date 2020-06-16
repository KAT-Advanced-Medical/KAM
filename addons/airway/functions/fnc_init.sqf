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

_unit setVariable [QGVAR(obstruction), false, true];
_unit setVariable [QGVAR(airway), false, true];
_unit setVariable [QGVAR(overstretch), false, true];
_unit setVariable [QGVAR(startTime), 0, true];

//This is a temp workaround till the adjustSPO2 part is rewritten
0 spawn {
	sleep 2;
	_unit setVariable [QGVAR(airway_item), "", true];
}
