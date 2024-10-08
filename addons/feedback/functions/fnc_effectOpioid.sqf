#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Triggers the opiod effect.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectOpiod;
 *
 * Public: No
 */

params ["_enable", "_intensity"];
if !GVAR(enableOpioidEffect) exitWith {};
if (!_enable || {_intensity < 0.15}) exitWith {
    if (GVAR(opioidEffect) != -1) then { GVAR(opioidEffect) ppEffectEnable false; };
};
if (GVAR(opioidEffect) != -1) then { GVAR(opioidEffect) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showOpioidNextTick), true];
GVAR(showOpioidNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

_intensity     = linearConversion [0, 1, _intensity, 0, 1, true];
_initialAdjust = [_intensity       , _intensity       , true];
_delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];

GVAR(opioidEffect) ppEffectAdjust _initialAdjust;
GVAR(opioidEffect) ppEffectCommit FX_OPIOD_FADE_IN;
[{
    params ["_adjust"];
    GVAR(opioidEffect) ppEffectAdjust _adjust;
    GVAR(opioidEffect) ppEffectCommit FX_OPIOD_FADE_OUT;
}, [_delayedAdjust], FX_OPIOD_FADE_IN] call CBA_fnc_waitAndExecute;
