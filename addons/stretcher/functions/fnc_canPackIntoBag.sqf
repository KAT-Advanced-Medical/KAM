#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if stretcher can be packed into bag
 *
 * Arguments:
 * 0: Stretcher <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [cursorTarget] call kat_stretcher_fnc_canPackIntoBag;
 *
 * Public: No
 */

params ["_stretcher"];

alive _stretcher && {((crew _stretcher) findIf {alive _x && {!unitIsUAV _x}}) == -1} // return