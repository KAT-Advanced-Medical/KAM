#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Checks if player can detach helistretcher to helicopter
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Example:
 * [player, cursorObject] call kat_stretcher_fnc_canDetachHeliStretcher;
 *
 * Public: No
 */

params ["_target"];

(_target getVariable [QGVAR(isStretcherAttached), false])