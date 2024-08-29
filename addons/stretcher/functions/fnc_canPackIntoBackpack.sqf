#include "..\script_component.hpp"
/*
 * Author: MiszczuPolski
 * Checks if stretcher can be packed into backpack
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

params ["_target"];

[true, false] select ((count crew _target > 0) || !(isNull attachedTo _target))
