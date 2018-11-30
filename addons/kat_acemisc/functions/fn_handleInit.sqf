/*
 * Author: Katalam
 * Handle unit init.
 *
 * Arguments:
 * 0: Unit <OBJECT>
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
