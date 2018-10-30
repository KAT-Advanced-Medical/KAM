/*
 * Author: Katalam
 * Handles remove clothes function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceDisability_fnc_treatmentAdvanced_clothes;
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
  ["treatmentClothes", [_player, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentClothes", [_player, _target], _target] call CBA_fnc_targetEvent;
};
