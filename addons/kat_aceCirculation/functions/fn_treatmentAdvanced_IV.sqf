/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, 'Blood_IV_A'] call kat_aceCirculation_fnc_treatmentAdvanced_IV
 *
 * Public: No
 */

params ["_unit", "_className"];

if !(local _unit) exitWith {["treatmentIVfalse", [_unit, _className], _unit] call CBA_fnc_targetEvent};

private _counts = _unit getVariable ["kat_aceCirculation_IV_counts", 0];
if (_counts isEqualTo 0) then {_counts = 1};
private _ppEffect = (0.01 * _counts);

private _effect = ppEffectCreate ["chromAberration", 5000];
_effect ppEffectEnable true;
_effect ppEffectForceInNVG true;
_effect ppEffectAdjust [_ppEffect, _ppEffect, false];
_effect ppEffectCommit 0.01;

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "IV" >> _className >> "volume");
private _hradjust = _volume / 25;
[_unit, _hradjust, 60] call ace_medical_fnc_addHeartRateAdjustment;

//todo tod?
private _a = (_unit getVariable ["kat_aceCirculation_IV_counts", 0]) + 1;
_unit setVariable ["kat_aceCirculation_IV_counts", _a, true];
