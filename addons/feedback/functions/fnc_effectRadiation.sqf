#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Triggers the radiation-sickness visual effect: a desaturated, sickly grade
 * that deepens with intensity. Driven by the radiation physiology tick from the
 * unit's sickness tier / dose-rate. Client-local.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity (0..1) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectRadiation;
 *
 * Public: No
 */

params ["_enable", "_intensity"];

if ((!_enable) || {_intensity <= 0}) exitWith {
    if (GVAR(radiationEffect) != -1) then { GVAR(radiationEffect) ppEffectEnable false; };
};

if (GVAR(radiationEffect) != -1) then { GVAR(radiationEffect) ppEffectEnable true; };

private _sat = 1 - (0.55 * _intensity);
private _tint = 0.4 * _intensity;

GVAR(radiationEffect) ppEffectAdjust [1, 1, _sat, [0.25, 0.4, 0.15, _tint], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
GVAR(radiationEffect) ppEffectCommit 1;
