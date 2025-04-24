#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient can be manually converted
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_manualConversionCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(IS_UNCONSCIOUS(_patient)) exitWith { false };
if (GVAR(allowManualConversion) && !(LIB_CONVERSION_DISTANCE(_patient))) exitWith { false };

true
