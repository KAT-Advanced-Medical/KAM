/*
 * Author: Katalam
 * Treatment for a pulmo injury
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceBreathing_fnc_treatmentAdvanced_pneumothorax;
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
  ["treatmentPneumothorax", [_player, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentPneumothorax", [_player, _target], _target] call CBA_fnc_targetEvent;
};
