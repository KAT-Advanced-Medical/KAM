/*
 * Author: Katalam
 * Handle the treatment for the patient cause calling two functions in one action isnt allowed
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 'hand_l', 'BloodIV_O', _items] call kat_aceCirculation_fnc_handleTreatment
 *
 * Public: No
 */

params ["_caller", "_target", "_selectionName", "_className", "_items"];

[_caller, _target, _selectionName, _className, _items] call ace_medical_fnc_treatmentIV;
if ([_target, _className] call kat_aceCirculation_fnc_compatible) exitWith {};
[_target, _className] call kat_aceCirculation_fnc_treatmentAdvanced_IV;
