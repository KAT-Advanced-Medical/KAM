#include "..\script_component.hpp"
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

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

_unit setVariable [QGVAR(airwayStatus), 100, true];

_unit setVariable [QGVAR(etco2Level), 40, true];
_unit setVariable [QGVAR(breathRate), 15, true];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable [QGVAR(PulseOximeter_Volume), true, true];
_unit setVariable [QGVAR(PulseOximeter_VolumePatient), false, true];

_unit setVariable [QGVAR(etco2Monitor), [], true];
_unit setVariable [QGVAR(nasalCannula), false, true];