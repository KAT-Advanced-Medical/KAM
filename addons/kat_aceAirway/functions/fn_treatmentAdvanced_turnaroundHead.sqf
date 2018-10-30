/*
 * Author: Katalam
 * turns the head of the patient for airway management without items
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
 * [bob1, bob2] call kat_aceAirway_fnc_treatmentAdvanced_turnaroundHead
 *
 * Public: No
 */

params ["_player", "_target"];

if !(_target getVariable ["ace_medical_airwayOccluded", false]) exitWith {
   _output = localize "STR_kat_aceAirway_Airway_NA";
   [_output, 2, _caller] call ace_common_fnc_displayTextStructured;
   false;
};

// head turning animation?

_output = localize "STR_kat_aceAirway_turnaround_info";
[_output, 1.5, _player] call ace_common_fnc_displayTextStructured;

if (random 100 < 35) then {
  _target setVariable ["ace_medical_airwayOccluded", false, true];
};
