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
 * [player] call kat_pharma_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(flowRate), 1, true];
_unit setVariable [QGVAR(IVplaced), false, true];
_unit setVariable [QGVAR(usedIV), "", true];
_unit setVariable [QGVAR(IV_counts), 0, true];
_unit setVariable [QGVAR(IVsite), 0, true];

_unit setVariable [QGVAR(ondUse), false, true];