#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Will initialize the frame handler for the manual blinking and dust injuries
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);
