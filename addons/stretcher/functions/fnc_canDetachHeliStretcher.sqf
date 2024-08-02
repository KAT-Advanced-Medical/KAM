#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Checks if player can detach helistretcher to helicopter
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Helicopter <OBJECT>
 *
 * Example:
 * [player, cursorObject] call kat_stretcher_fnc_canDetachHeliStretcher;
 *
 * Public: No
 */

params ["_player","_target"];

(_target getVariable [QGVAR(isStretcherAttached), false])