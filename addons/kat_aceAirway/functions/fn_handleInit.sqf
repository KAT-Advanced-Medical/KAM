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

diag_log text format ["Unit: %1", _this select 0];
diag_log text "handleInit";

params ["_unit"];

_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_fnc_handleDamage_airway;}];
_unit addEventHandler ["Respawn", {_this call kat_aceAirway_fnc_handleDie;}];
_unit addEventHandler ["Killed", {_this call kat_aceAirway_fnc_handleDie;}];
_unit call kat_aceAirway_fnc_init;
