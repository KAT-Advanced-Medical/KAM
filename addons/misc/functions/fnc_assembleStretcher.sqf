#include "script_component.hpp"
/*
 * Author: Katalam
 * Assemble function for stretcher
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_misc_fnc_assembleStretcher;
 *
 * Public: No
 */

params ["_player"];

createVehicle ["kat_stretcher", getPos _player, [], 0, "CAN_COLLIDE"];
_player removeItem "kat_stretcher";
