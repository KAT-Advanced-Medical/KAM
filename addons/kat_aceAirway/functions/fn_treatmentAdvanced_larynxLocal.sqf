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
 * [bob, "classname"] call kat_aceAirway_fnc_treatmentlarynxLocal
 *
 * Public: No
 */

params ["_target", "_larynxItem", "_selectionName"];

if (_target getVariable ["ace_medical_inReviveState", false]) then {
  _target setVariable ["kat_aceAirway_airwayl", true, true];
};

_target setVariable ["ace_medical_airwayCollapsed", false];

[_target, _larynxItem] call ace_medical_fnc_addToTriageCard;

true;
