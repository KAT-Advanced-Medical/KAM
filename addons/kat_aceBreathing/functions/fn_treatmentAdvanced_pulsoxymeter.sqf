/*
 * Author: Katalam
 * docks a pulsximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceBreathing_fnc_treatmentAdvanced_pulsoxymeter;
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
  ["treatmentPulsoxymeter", [_player, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentPulsoxymeter", [_player, _target], _target] call CBA_fnc_targetEvent;
};
