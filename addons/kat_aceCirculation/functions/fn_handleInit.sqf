/*
 * Author: Katalam
 * Handle the unit init.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceCirculation_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

//_unit addEventHandler ["HandleDamage", {_this call kat_aceAirway_fnc_handleDamage_airway;}];
_unit call kat_aceCirculation_fnc_init;
