/*
 * Author: Katalam
 * Condition check for the medicine IV stands to add a bag.
 *
 * Arguments:
 * 0: _player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceMisc_fnc_conditionIVstand;
 *
 * Public: No
 */

params ["_player"];

if !(kat_aceMisc_enable) exitWith {false};

if ([_player] call ace_medical_fnc_isMedic && "ACE_salineIV" in items _player) exitWith {true};
false;
