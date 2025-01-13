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

if !(GVAR(enableConversionDistance)) exitWith { true };
if ((_unit distance2d ([getPos _unit] call KPLIB_fnc_getNearestFob)) > enableLiberationConversionDistance) exitWith { true };

false