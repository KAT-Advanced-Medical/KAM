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

params ["_target", "_medic", "_item"];

if (_item isEqualTo "Amiodarone") then {
    [_target, "Amiodarone", 0, 60, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;

    private _random = random 2;

    if (_random == 1) then {
        [_patient, "BRADYCARDIA", 120, 1200, -15, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;
    };
};

if (_item isEqualTo "Lidocaine") then {
    [_target, "Lidocaine", 0, 60, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;
};

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;

true