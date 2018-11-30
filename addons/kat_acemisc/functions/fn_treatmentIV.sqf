/*
 * Author: Katalam
 * Treatment handle function to remove a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 'SalineIV', 'hand_r', ['SalineIV']] call kat_aceMisc_fnc_treatmentIV;
 *
 * Public: No
 */

params ["_player", "_target", "_selectionName", "_className", "_items"];

[_player] call kat_aceMisc_fnc_removeIVbag;
[_player, _target, _selectionName, _className, _items] call ace_medical_fnc_treatmentIV;
