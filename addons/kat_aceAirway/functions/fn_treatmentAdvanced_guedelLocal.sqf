/*
 * Author: Katalam
 * Handles the airway management of a patient.
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Treatment classname <STRING>
 *
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [bob, "classname"] call kat_aceAirway_fnc_treatmentAdvanced_bandageLocal
 *
 * Public: No
 */

params ["_target", "_className", "_selectionName", ["_specificClass", -1]];

if (_target getVariable [QGVAR(inReviveState), false]) then {
  _target setVariable [QGVAR(airwayCollapsed), false];
};

private _part = [_selectionName] call FUNC(selectionNameToNumber);

// Place a management on the bodypart
private _airway = _target getVariable [QGVAR(airwayg), false];
_airway set [_part];
_target setVariable [QGVAR(airwayg), _airway, true];

[_target, _className] call FUNC(addToTriageCard);

true;
