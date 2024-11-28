#include "..\script_component.hpp"
/*
 * Author: apo_tle, MiszczuZPolski
 * Triggers the minor CMR effect, radial blur.
 *
* Arguments:
 * 0: Enable <BOOL>
 * 1: Current CMR <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectMinorLossCMR;
 *
 * Public: No
 */

params ["_enable", "_cmr"];

if !GVAR(enableBrainEffect) exitWith {};
if ((!_enable) || {_cmr > 200}) exitWith {
    if (GVAR(minorLossCMR) != -1) then { GVAR(minorLossCMR) ppEffectEnable false; };
};
if (GVAR(minorLossCMR) != -1) then { GVAR(minorLossCMR) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showBrainNextTick), true];
GVAR(showBrainNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

_initialAdjust = [1.5];
_delayedAdjust = [0];

GVAR(minorLossCMR) ppEffectAdjust _initialAdjust;
GVAR(minorLossCMR) ppEffectCommit FX_MINOR_CMR_FADE_IN;
[{
    params ["_adjust"];
    GVAR(minorLossCMR) ppEffectAdjust _adjust;
    GVAR(minorLossCMR) ppEffectCommit FX_MINOR_CMR_FADE_OUT;
}, [_delayedAdjust], FX_MINOR_CMR_FADE_IN] call CBA_fnc_waitAndExecute;
