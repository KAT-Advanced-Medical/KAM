/*
 * Author: Katalam
 * Unit Init Handler
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceAirway_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

if !(kat_aceAirway_enable) exitWith {};

_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_fnc_handleDamage_airway;}];
_unit addEventHandler ["Respawn", {_this call kat_aceAirway_fnc_handleDie;}];
_unit addEventHandler ["Killed", {_this call kat_aceAirway_fnc_handleDie;}];
_unit call kat_aceAirway_fnc_init;
