/*
 * Author: Katalam
 * Remove the false blood effect for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceCirculation_fnc_removeEffect_IV;
 *
 * Public: No
 */

params ["_unit"];

if !(local _unit) exitWith {["IVreset", [_unit], _unit] call CBA_fnc_targetEvent};

private _effect = ppEffectCreate ["chromAberration", 5000];
_effect ppEffectEnable true;
_effect ppEffectForceInNVG true;
_effect ppEffectAdjust [0, 0, false];
_effect ppEffectCommit 0.01;

_unit setVariable ["kat_aceCirculation_IV_counts", 0, true];
