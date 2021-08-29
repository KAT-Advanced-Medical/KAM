#include "script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

if (!local _unit) exitWith {};

_unit setVariable [QGVAR(IV_counts), 0, true];
_unit setVariable [QGVAR(X), false, true];
_unit setVariable [QGVAR(X_sound1), QPATHTOF_SOUND(sounds\noheartrate.wav), true];
_unit setVariable [QGVAR(X_sound2), QPATHTOF_SOUND(sounds\heartrate.wav), true];
_unit setVariable [QGVAR(use), false, true];
_unit setVariable [QGVAR(returnedAED), false, true];