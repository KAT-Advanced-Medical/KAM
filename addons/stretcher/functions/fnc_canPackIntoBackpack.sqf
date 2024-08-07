#include "..\script_component.hpp"
/*
 * Author: MiszczuPolski
 * Checks if stretcher can be packed into backpack
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Stretcher <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_stretcher_fnc_canPackIntoBag;
 *
 * Public: No
 */

params ["_player", "_target"];

if ((count crew _target > 0) || !(isNull attachedTo _target)) exitWith {false};
true;