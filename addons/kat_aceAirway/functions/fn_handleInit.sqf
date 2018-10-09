/*
 * Author: Katalam
 * Called when a unit is initialized via XEH_init
 *
 * Arguments:
 * 0: The Unit <OBJECT>
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
_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_handleDamage_airway}];
_unit addEventHandler ["Respawn", {_this call kat_aceAirway_handleRespawn}];
_unit addEventHandler ["Killed", {_this call kat_aceAirway_handleKilled}];
[_unit] call kat_aceAirway_fnc_init;
