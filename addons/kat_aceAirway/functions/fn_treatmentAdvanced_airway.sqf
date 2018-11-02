/*
 * Author: Katalam
 * Airway Management
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [medic, patient, "Larynxtubus"] call kat_aceAirway_fnc_treatmentAdvanced_airway
 *
 * Public: Yes
 */

params ["_caller", "_target", "_className"];

if (local _target) then {
  ["treatmentAirway", [_caller, _target, _className]] call CBA_fnc_localEvent;
} else {
  ["treatmentAirway", [_caller, _target, _className], _target] call CBA_fnc_targetEvent;
};

true;
