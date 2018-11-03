/*
 * Author: Katalam
 * Called when a unit is initialized
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceBreathing_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

_unit call kat_aceBreathing_fnc_init;
