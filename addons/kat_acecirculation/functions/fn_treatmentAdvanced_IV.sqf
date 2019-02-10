/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: Successful <BOOLEAN>
 *
 * Example:
 * ['Blood_IV_A', cursorTarget] call kat_aceCirculation_fnc_treatmentAdvanced_IV
 *
 * Public: No
 */

params ["_className", "_target"];

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "IV" >> _className >> "volume");
private _hradjust = _volume / 25;
[_target, _hradjust, 60] call ace_medical_fnc_addHeartRateAdjustment;

//todo tod?
private _a = (_target getVariable ["kat_aceCirculation_IV_counts", 0]) + 1;
_target setVariable ["kat_aceCirculation_IV_counts", _a, true];
