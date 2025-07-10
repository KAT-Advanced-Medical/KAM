#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient is far enough away from a Liberation FOB to be converted
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_libConversionDistance
 *
 * Public: No
 */

params ["_patient"];

if ((missionNamespace getVariable ["GRLIB_fob_range", -1]) == -1) exitWith { true };
if !(GVAR(enableLiberationConversion)) exitWith { true };
if !(GVAR(enableConversionDistance)) exitWith { true };
if ((_patient distance2D ([getPos _patient] call KPLIB_fnc_getNearestFob)) < enableLiberationConversionDistance) exitWith { true };

false