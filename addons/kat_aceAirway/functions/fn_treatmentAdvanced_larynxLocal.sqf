/*
 * Author: Katalam
 * Handles the airway management of a patient.
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Item used classname <STRING>
 *
 *
 * Return Value:
 * True
 *
 * Example:
 * [bob, "classname"] call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal
 *
 * Public: No
 */

diag_log text format ["Medic: %1", _this select 0];
diag_log text format ["Patient: %1", _this select 1];
diag_log text "treatmentAdvanced_larynxLocal";

params ["_target", "_Item"];

if (_target getVariable ["ace_medical_inReviveState", false]) then {
  _target setVariable ["kat_aceAirway_airway", true, true];
  _target setVariable ["kat_aceAirway_airway_item", "larynx"];
};

_target setVariable ["ace_medical_airwayCollapsed", false];

[_target, _Item] call ace_medical_fnc_addToTriageCard;

true;
