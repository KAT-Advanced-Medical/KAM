/*
 * Author: Katalam
 * Fast trauma search
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_treatmentAdvanced_ftsLocal;
 *
 * Public: No
 */

params ["_player", "_target"];

if !(local _target) exitWith {
  ["treatmentFts", [_player, _target]] call CBA_fnc_targetEvent;
};

// condition for trachea cut, ther will be NO trachea cut without a complete body check
_target setVariable ["kat_aceDisability_checked", true, true];

// message output
private _string = "STR_kat_aceDisability_Action_Message_1_nothing";
switch ((_target getVariable "kat_aceDisability_allergicalreaction") select 0) do {
  case "HoneyBee": {
    _string = "STR_kat_aceDisability_Action_Message_1_bee";
  };
  default {};
};

// medical menu output
[_target, "quick_view", localize "STR_kat_aceDisability_cut_log", [[_player] call ace_common_fnc_getName, localize _string]] call ace_medical_fnc_addToLog;

// player hint
private _message = format [localize "STR_kat_aceDisability_Action_Message", localize _string];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;
