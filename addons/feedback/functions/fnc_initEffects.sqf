#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Initializes visual effects of medical.
 *
 * Arguments:
 * 0: Update pain and low blood volume effects only <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call ace_medical_feedback_fnc_initEffects
 *
 * Public: No
 */

params [["_updateOnly", false]];

TRACE_1("initEffects",_updateOnly);

private _fnc_createEffect = {
    params ["_type", "_layer", "_default"];

    private _effect = ppEffectCreate [_type, _layer];
    _effect ppEffectForceInNVG true;
    _effect ppEffectAdjust _default;
    _effect ppEffectCommit 0;

    _effect
};

if (_updateOnly) exitWith {};

// - Opioid -----------------------------------------------------------
GVAR(opioidEffect) = [
    "ChromAberration",
    213701,
    [0, 0, true ]
] call _fnc_createEffect;

// - Low SpO2 -----------------------------------------------------------
GVAR(lowSpO2) = [
    "ColorCorrections",
    213702,
    [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]]
] call _fnc_createEffect;

GVAR(airPoisoning) = [
    "ChromAberration",
    213703,
    [0, 0, true]
] call _fnc_createEffect;

GVAR(tearHaze) = [
    "WetDistortion",
    213704,
    [1,
    1, 1,
    4.10, 3.70, 2.50, 1.85,
    0.0054, 0.0041, 0.0090, 0.0070,
    0.5, 0.3, 10.0, 6.0]
] call _fnc_createEffect;
