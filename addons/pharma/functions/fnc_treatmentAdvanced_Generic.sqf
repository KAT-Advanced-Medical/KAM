#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Generic Medication Function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Generic;
 *
 * Public: No
 */

params ["_medic", "_patient", "_medication"];

if (local _patient) then {
    ["treatmentGeneric", [_patient, _medic, _medication]] call CBA_fnc_localEvent;
} else {
    ["treatmentGeneric", [_patient, _medic, _medication], _patient] call CBA_fnc_targetEvent;
};

true;