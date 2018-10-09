/*
 * Author: Katalam
 * Called when a unit is Respawned
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: The Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_handleRespawn
 *
 * Public: No
 */

params ["_unit", "_corpse"];
if (!local _unit) exitWith {};
[_unit] call kat_aceAirway_fnc_init;
