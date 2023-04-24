#include "script_component.hpp"
/*
 * Author: Katalam
 * Will initialize the frame handler for the manual blinking
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

if (!GVAR(enable)) exitWith {};

[FUNC(handleTime), 1, _unit] call CBA_fnc_addPerFrameHandler;
