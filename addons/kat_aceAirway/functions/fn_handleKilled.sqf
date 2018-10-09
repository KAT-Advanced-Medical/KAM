/*
 * Author: Katalam
 * Called when a unit is killed
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_handleKilled
 *
 * Public: No
 */

params ["_unit"];
if (!local _unit) exitWith {};
[_unit] call kat_aceAirway_fnc_init;
