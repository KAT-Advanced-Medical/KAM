/*
 * Author: Katalam
 * Handle the treatment for the patient cause calling two functions in one action isn't allowed.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Successful <BOOLEAN>
 *
 * Example:
 * [player, cursorTarget, 'hand_l', 'BloodIV_A', 'BloodIV_A'] call kat_aceCirculation_fnc_handleTreatment;
 *
 * Public: No
 */

params ["_player", "_target", "_selectionName", "_className", "_items"];
//[abc,abcd,"hand_r","BloodIV_A",["KAT_bloodIV_A"]]
private _return = false;

[_player, _target, _selectionName, _className, _items] call ace_medical_fnc_treatmentIV;

if ([_target, _className] call kat_aceCirculation_fnc_compatible) exitWith {};

[_className, _target] call kat_aceCirculation_fnc_treatmentAdvanced_IV;

_return = true;
_return;
