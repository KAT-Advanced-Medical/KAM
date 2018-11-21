/*
 * Author: Katalam
 * Called when a unit is initialized via XEH_init
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceMisc_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

_unit call kat_aceMisc_fnc_init;
