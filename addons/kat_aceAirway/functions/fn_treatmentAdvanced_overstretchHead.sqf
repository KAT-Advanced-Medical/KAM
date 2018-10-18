/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
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
/*
_target setVariable ["kat_aceAirway_overstretch", true];

if (local _player) then {
  hint localize "STR_kat_aceAirway_overstretch_info";
} else {
  "$STR_kat_aceAirway_overstretch_info" remoteExec ["hint", _player, false];
};

/*
  [true] remoteExec ["disableUserInput", _player, false];
  Existing Problem for activating UserInput
*/
/*
[{
  _target setVariable ["kat_aceAirway_overstretch", false];
}, {
  (_target distance2D _player) > 5;
  if (local _player) then {
    hint localize "STR_kat_aceAirway_overstretch_cancel";
  } else {
    ["$STR_kat_aceAirway_overstretch_cancel"] remoteExec ["hint", _player, false];
  }
}, [_target. _player], 120, {
  (_target distance2D _player) > 5;
  if (local _player) then {
    hint localize "STR_kat_aceAirway_overstretch_cancel";
  } else {
    ["$STR_kat_aceAirway_overstretch_cancel"] remoteExec ["hint", _player, false];
  };
}] call CBA_fnc_waitUntilAndExecute;
*/
