#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski & Digii
 * Triggers the coughing effect.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectCoughing;
 *
 * Public: No
 */

params ["_enable", "_poisoned"];
if (!_enable || !_poisoned) exitWith {
    if (GVAR(airPoisoning) != -1) then { GVAR(airPoisoning) ppEffectEnable false; };
};
if (GVAR(airPoisoning) != -1) then { GVAR(airPoisoning) ppEffectEnable true; };

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showCoughNextTick), true];
GVAR(showCoughNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

_unit say3D QEGVAR(chemical,cough_1);
addCamShake [3, 4, 0];

private _initialAdjust = [];
private _delayedAdjust = [];

private _intensity = linearConversion [0, 1, 0.5, 0, 0.06, true];
_initialAdjust = [_intensity, _intensity, true];
_delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];

GVAR(airPoisoning) ppEffectAdjust _initialAdjust;
GVAR(airPoisoning) ppEffectCommit FX_COUGH_FADE_IN;

[{
    params ["_adjust"];
    GVAR(airPoisoning) ppEffectAdjust _adjust;
    GVAR(airPoisoning) ppEffectCommit FX_COUGH_FADE_OUT;
}, [_delayedAdjust], 3] call CBA_fnc_waitAndExecute;
