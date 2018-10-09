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

params ["_target", "_selectionName"];

if (_target getVariable [QGVAR(inReviveState), false]) then {
  _target setVariable [QGVAR(airwayOccluded), false];
};

true;
