/*
 * Author: Katalam
 * Condition check for the medicine IV stands to add a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Cann add IV bag <BOOLEAN>
 *
 * Example:
 * [player] call kat_aceMisc_fnc_conditionIVstand;
 *
 * Public: No
 */

 params [
     ["_player", objNull, [objNull]],
     ["_classname", "ACE_salineIV", [""]]
 ];

if !(kat_aceMisc_enable) exitWith {false};

if ([_player] call ace_medical_fnc_isMedic && _classname in items _player) exitWith {true};
false;
