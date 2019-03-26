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
 * [bob] call kat_acebreathing_fnc_init
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(o2), false, true];
// ace_medical_airwayStatus - oxygen saturation
