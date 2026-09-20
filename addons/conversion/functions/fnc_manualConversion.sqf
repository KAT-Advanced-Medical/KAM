#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Performs initial patient conversion
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_manualConversion
 *
 * Public: No
 */

 params ["_medic", "_patient"];

[QGVAR(convertCasualty), _patient] call CBA_fnc_localEvent;