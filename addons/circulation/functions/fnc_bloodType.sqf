#include "script_component.hpp"
/*
 * Author: Katalam
 * Reports a blood type depending on the unit.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * 0: Blood type <STRING>
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_bloodType;
 *
 * Public: No
 */

params ["_target"];

_target getVariable [QGVAR(bloodtype), "O"];
