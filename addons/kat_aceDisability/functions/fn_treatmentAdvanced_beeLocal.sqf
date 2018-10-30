/*
 * Author: Katalam
 * Function for treatment of the allergical reaction to a bee thing
 *
 * Arguments:
 * 0: _target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceDisability_fnc_treatmentAdvanced_beeLocal;
 *
 * Public: No
 */

params ["_unit", "_target"];

//_unit setVariable ["kat_aceDisability_allergicalreaction", false];
_target setVariable ["kat_aceAirway_swollen", false];
[_target, false] call ace_medical_fnc_setUnconscious;
_target setVariable ["kat_aceDisability_checked", false];

_output = localize "STR_kat_aceDisability_Done";
[_output, 1.5, _unit] call ace_common_fnc_displayTextStructured;

_message = "STR_kat_aceDisability_Action_Message_1_nothing";
if (_target getVariable ["kat_aceDisability_allergicalreaction", false]) then {
  _message = "STR_kat_aceDisability_Action_Message_1_bee";
  [_target, "activity", localize "STR_kat_aceDisability_cut_log", [[_unit] call ace_common_fnc_getName, localize _message]] call ace_medical_fnc_addToLog;
};
[_target, "quick_view", localize "STR_kat_aceDisability_cut_log", [[_unit] call ace_common_fnc_getName, localize _message]] call ace_medical_fnc_addToLog;
