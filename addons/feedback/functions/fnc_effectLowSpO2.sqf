#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Digii
 * Modified by MiszczuZPolski
 * Triggers the low SPO2 visual effect.
 *
* Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectLowSpO2;
 *
 * Public: No
 */

params ["_enable", "_intensity"];

if ((!_enable) || {_intensity == 0}) exitWith {
    if (GVAR(lowSpO2) != -1) then { GVAR(lowSpO2) ppEffectEnable false; };
};
if (GVAR(lowSpO2) != -1) then { GVAR(lowSpO2) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showLowSpO2NextTick), true];
GVAR(showLowSpO2NextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

_initialAdjust = [1, 1, 0, [0, 0, 0, 0.9], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
_delayedAdjust = [1, 1, 0, [0, 0, 0, 0.1], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];

GVAR(lowSpO2) ppEffectAdjust _initialAdjust;
GVAR(lowSpO2) ppEffectCommit FX_SPO2_FADE_IN;
[{
    params ["_adjust"];
    GVAR(lowSpO2) ppEffectAdjust _adjust;
    GVAR(lowSpO2) ppEffectCommit FX_SPO2_FADE_OUT;
}, [_delayedAdjust], FX_SPO2_FADE_IN] call CBA_fnc_waitAndExecute;
