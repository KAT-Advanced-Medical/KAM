#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Medication <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_accuvac;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_medication"];

if (local _patient) then {
    ["treatmentGeneric", [_patient, _medic, _medication]] call CBA_fnc_localEvent;
} else {
    ["treatmentGeneric", [_patient, _medic, _medication], _patient] call CBA_fnc_targetEvent;
};

true;