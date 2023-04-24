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

_unit setVariable [QGVAR(airwayStatus), 100, true];
_unit setVariable [QGVAR(pneumothorax), false, true];
_unit setVariable [QGVAR(hemopneumothorax), false, true];
_unit setVariable [QGVAR(tensionpneumothorax), false, true];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(PulseOximeter_Volume), true, true];
_unit setVariable [QGVAR(PulseOximeter_VolumePatient), false, true];