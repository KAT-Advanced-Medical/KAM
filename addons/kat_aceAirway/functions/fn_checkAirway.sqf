/*
 * Author: Katalam
 * Checks need of airway management
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_aceAirway_fnc_checkAirway;
 *
 * Public: No
 */

params ["_player", "_target"];

_messageairwayCollapsed = localize "STR_kat_aceAirway_message_Collapsed_no";
_messageairwayOccluded = localize"STR_kat_aceAirway_message_Occluded_no";
_yesornoCollapsed = localize "STR_kat_aceAirway_N";
_yesornoOccluded = localize "STR_kat_aceAirway_N";

if (_target getVariable ["ace_medical_airwayCollapsed", false]) then {
  _messageairwayCollapsed = localize "STR_kat_aceAirway_message_Collapsed_yes";
  _yesornoCollapsed = "";
  _target setVariable ["ace_medical_triageLevel", 3];
};
if (_target getVariable ["ace_medical_airwayOccluded", false]) then {
  _messageairwayOccluded = localize "STR_kat_aceAirway_message_Occluded_yes";
  _yesornoOccluded = "";
  _target setVariable ["ace_medical_triageLevel", 3];
};
if !((_target getVariable ["ace_medical_airwayOccluded", false]) && (_target getVariable ["ace_medical_airwayCollapsed", false])) then {_target setVariable ["ace_medical_triageLevel", 0]};
_message = format ["%1, %2", _messageairwayCollapsed, _messageairwayOccluded];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;

[_target, "quick_view", localize "STR_kat_aceAirway_checkAirway_log", [[_player] call ace_common_fnc_getName, _yesornoCollapsed, localize "STR_kat_aceAirway_Collapsed"]] call ace_medical_fnc_addToLog;
[_target, "quick_view", localize "STR_kat_aceAirway_checkAirway_log", [[_player] call ace_common_fnc_getName, _yesornoOccluded, localize "STR_kat_aceAirway_Occluded"]] call ace_medical_fnc_addToLog;
