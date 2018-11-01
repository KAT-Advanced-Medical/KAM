/*
 * Author: Katalam
 * Called when a unit is initialized via XEH_init
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: The Group <GROUP>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceCirculation_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

//_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_fnc_handleDamage_airway;}];
_unit call kat_aceCirculation_fnc_init;
