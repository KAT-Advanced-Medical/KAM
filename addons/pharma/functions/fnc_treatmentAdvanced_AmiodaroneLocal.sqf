#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Adds Medication to patient's logs
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_GenericLocal;
 *
 * Public: No
 */

params ["_patient"];

private _random = random 3;
if (_random <= 1) then {
    [_patient, "BRADYCARDIA", 120, 1200, -15, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;
};