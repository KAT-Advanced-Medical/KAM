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
 * [true, 0.5] call kat_feedback_fnc_effectairwayInjury;
 *
 * Public: No
 */

params ["_enable", "_enabled"];

if ((!_enable) || (!_enabled)) exitWith {
    if (GVAR(airwayInjury)!= -1) then { GVAR(airwayInjury) ppEffectEnable false; };
};
if (GVAR(airwayInjury)!= -1) then { GVAR(airwayInjury) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showAirwaysNextTick), true];
GVAR(showAirwaysNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

_initialAdjust = [1, 1, 0, [0, 0, 0, 0.9], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
_delayedAdjust = [1, 1, 0, [0, 0, 0, 0.1], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];

GVAR(airwayInjury) ppEffectAdjust _initialAdjust;
GVAR(airwayInjury) ppEffectCommit FX_SPO2_FADE_IN;
[{
    params ["_adjust"];
    GVAR(airwayInjury) ppEffectAdjust _adjust;
    GVAR(airwayInjury) ppEffectCommit FX_SPO2_FADE_OUT;
}, [_delayedAdjust], FX_SPO2_FADE_IN] call CBA_fnc_waitAndExecute;
