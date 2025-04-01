#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Initialize unit
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);
