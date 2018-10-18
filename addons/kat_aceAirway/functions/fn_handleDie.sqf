/*
 * Author: Katalam
 * Handling the deathtimer for airway injuries
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, time, "O"] call kat_aceAirway_fnc_handleDie;
 *
 * Public: No
 */

params ["_unit"];
if (!local _unit) exitWith {};
_unit call kat_aceAirway_fnc_init;
