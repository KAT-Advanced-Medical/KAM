#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka, Brett Mayson
 * Ensures proper initial values reset on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_chemical_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

if (!local _unit) exitWith {};

params ["_unit"];

[_unit] call FUNC(fullHealLocal);

_unit setVariable [QGVAR(detectorSound), false, true];
