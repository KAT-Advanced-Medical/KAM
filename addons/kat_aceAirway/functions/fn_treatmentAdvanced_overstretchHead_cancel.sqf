/*
 * Author: Katalam
 * Stops Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: The soldier <OBJECT>
 * 1: The patient <OBJECT>
 *
 *
 * Return Value:
 * True
 *
 * Example:
 * [bob1, bob2] call kat_aceAirway_fnc_treatmentAdvanced_overstretchHead
 *
 * Public: No
 */

params ["_player", "_target"];

_target setVariable ["kat_aceAirway_overstretch", false];

if (local _player) then {
  hint localize "STR_kat_aceAirway_overstretch_cancel";
} else {
  ["$STR_kat_aceAirway_overstretch_cancel"] remoteExec ["hint", _player, false];
};
