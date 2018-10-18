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
 * [bob1, bob2] call kat_aceAirway_fnc_checkAirway;
 *
 * Public: No
 */

params ["_player", "_target"];

_messageairwayCollapsed = "Kein Atemwegsmanagement erforderlich";
_messageairwayOccluded = "Absaugen nicht notwendig";

if (_target getVariable ["ace_medical_airwayCollapsed", false]) then {
  _messageairwayCollapsed = "Atemwegsmanagement erforderlich";
};
if (_target getVariable ["ace_medical_airwayOccluded", false]) then {
  _messageairwayOccluded = "Absaugen notwendig";
};
_message = format ["%1, %2", _messageairwayCollapsed, _messageairwayOccluded];
if (local _player) then {
  hint _message;
} else {
  _message remoteExec ["hint", _player, false];
};
