#include "script_component.hpp"
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

if (GVAR(enable)) then {
    [FUNC(handleDustInjury), 60, _unit] call CBA_fnc_addPerFrameHandler;
    [FUNC(handleDustInjuryEffects), 1, _unit] call CBA_fnc_addPerFrameHandler;
};

if (GVAR(enableManualBlinking)) then {
    [FUNC(handleTime), 1, _unit] call CBA_fnc_addPerFrameHandler;
};
