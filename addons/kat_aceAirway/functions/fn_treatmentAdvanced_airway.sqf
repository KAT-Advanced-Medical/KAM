/*
 * Author: Katalam
 * Airway Management for collapsing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus"] call kat_aceAirway_fnc_treatmentAdvanced_airway;
 *
 * Public: No
 */

params ["_caller", "_target", "_className"];

if (local _target) then {
  ["treatmentAirway", [_caller, _target, _className]] call CBA_fnc_localEvent;
} else {
  ["treatmentAirway", [_caller, _target, _className], _target] call CBA_fnc_targetEvent;
};

true;
