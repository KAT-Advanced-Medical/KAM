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
 * [bob] call kat_aceDisability_fnc_init
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable ["kat_aceDisability_allergicalreaction", [], true];
_unit setVariable ["kat_aceDisability_checked", false, true];
