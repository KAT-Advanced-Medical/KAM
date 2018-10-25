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

_string = localize "STR_kat_aceDisability_Action_Message_1_nothing";
if (_target getVariable "kat_aceDisability_allergicalreaction") then {
  _string = localize "STR_kat_aceDisability_Action_Message_1_bee";
};
_message = format [localize "STR_kat_aceDisability_Action_Message", _string];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;
