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
 * call kat_aceBreathing_fnc_treatmentAdvanced_pulsoximeter;
 *
 * Public: No
 */

params ["_player", "_target"];

if (_target getVariable ["kat_aceBreathing_pulsoximeter", false]) exitWith {
  _output = localize "STR_kat_aceBreathing_pulsoxi_NA";
  [_output, 2, _caller] call ace_common_fnc_displayTextStructured;
  false;
  /*
  Here come the ability to use the pulsoximeter from the patient. findDisplay or some shit in this direction
  */
};
