/*
 * Author: Katalam
 * Remove clothes function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_treatmentAdvanced_clothesLocal;
 *
 * Public: No
 */

params ["_player", "_target"];

if !(uniform _target isEqualTo "") then {
  removeUniform _target;
};
[localize "STR_kat_aceDisability_Action_Message", 1.5, _player] call ace_common_fnc_displayTextStructured;
