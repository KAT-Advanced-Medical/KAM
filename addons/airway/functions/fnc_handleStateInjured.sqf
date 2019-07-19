#include "script_component.hpp"
/*
 * Author: Katalam
 * Handling the respawn for any reason for airway damage
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call KAM_airway_fnc_handleStateInjured
 *
 * Public: No
 */

params ["_unit", "_woundedHitPoint", "_receivedDamage", "", "_ammo"];

// If the unit died the loop is finished
if (!alive _unit) exitWith {};
if (!local _unit) exitWith {};
