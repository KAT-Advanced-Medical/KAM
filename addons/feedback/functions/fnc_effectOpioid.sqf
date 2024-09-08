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

if (!_enable || {_intensity == 0}) exitWith {
    if (GVAR(ketamineEffect) != -1) then { GVAR(ketamineEffect) ppEffectEnable false; };
};
if (GVAR(ketamineEffect) != -1) then { GVAR(ketamineEffect) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showKetamineNextTick), true];
GVAR(showKetamineNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

_intensity     = linearConversion [0, 1, _intensity, 0, 1, true];
_initialAdjust = [_intensity       , _intensity       , true];
_delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];

GVAR(ketamineEffect) ppEffectAdjust _initialAdjust;
GVAR(ketamineEffect) ppEffectCommit FX_OPIOD_FADE_IN;
[{
    params ["_adjust"];
    GVAR(ketamineEffect) ppEffectAdjust _adjust;
    GVAR(ketamineEffect) ppEffectCommit FX_OPIOD_FADE_OUT;
}, [_delayedAdjust], FX_OPIOD_FADE_IN] call CBA_fnc_waitAndExecute;
