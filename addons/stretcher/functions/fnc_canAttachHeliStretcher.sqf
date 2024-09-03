#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Checks if player can attach helistretcher to helicopter
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Helicopter <OBJECT>
 *
 * Example:
 * [player, cursorObject] call kat_stretcher_fnc_canAttachHeliStretcher;
 *
 * Public: No
 */

params ["_player","_target"];

[_player, "kat_helistretcher"] call ACEFUNC(common,hasItem)
&& !(_target getVariable [QGVAR(isStretcherAttached), false])