#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Fentanyl Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Fentanyl;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentFentanyl", [_patient, "Fentanyl"]] call CBA_fnc_localEvent;
} else {
    ["treatmentFentanyl", [_patient, "Fentanyl"], _patient] call CBA_fnc_targetEvent;
};

true;