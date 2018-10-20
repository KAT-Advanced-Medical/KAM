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
 * [bob] call kat_aceAirway_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_fnc_handleDamage_airway;}];
_unit addEventHandler ["Respawn", {_this call kat_aceAirway_fnc_handleDie;}];
_unit addEventHandler ["Killed", {_this call kat_aceAirway_fnc_handleDie;}];
_unit call kat_aceAirway_fnc_init;
