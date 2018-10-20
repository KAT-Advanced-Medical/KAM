/*
 * Author: Katalam
 * Handling the respawn for any reason for airway injuries
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_handleDie;
 *
 * Public: No
 */

params ["_unit"];
if (!local _unit) exitWith {};
_unit call kat_aceAirway_fnc_init;
