#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
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
 * [cursorTarget] call kat_stretcher_fnc_canPackIntoBag;
 *
 * Public: No
 */

params ["_tripod"];

alive _tripod && {((crew _tripod) findIf {alive _x && {!unitIsUAV _x}}) == -1} // return