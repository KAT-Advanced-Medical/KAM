#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient can be converted into Liberation Supply
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_libConversionCondition
 *
 * Public: No
 */

params ["_patient"];

if !(GVAR(enableLiberationConversion)) exitWith { false };
if ((missionNamespace getVariable ["GRLIB_fob_range", -1]) == -1) exitWith { false };
if !(_patient getVariable [QGVAR(currentConverted), false]) exitWith { false };

if ((_patient distance2D ([getPos _patient] call KPLIB_fnc_getNearestFob)) > GRLIB_fob_range) exitWith { false };

if !([_patient] call FUNC(conversionCondition)) exitWith { false };

if (GVAR(forceVehicleConversion) && ((isNull objectParent _patient) || !((objectParent _patient) in GVAR(convertVehicles)))) exitWith { false };

true