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

params ["_target", "_item"];

if (_target getVariable ["ace_medical_airwayOccluded", false]) then {
  _target setVariable ["ace_medical_airwayOccluded", false, true];
};
playsound3D ["kat_aceAirway\sounds\Suction.wav", _target, false, getPosASL _target, 8, 1, 15];

[_target, _Item] call ace_medical_fnc_addToTriageCard;

true;
