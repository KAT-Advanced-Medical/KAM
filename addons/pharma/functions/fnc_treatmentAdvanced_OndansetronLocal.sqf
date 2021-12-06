#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Locates and Removes 1x Morphine after the administration of Naloxone.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Ondansetron"] call kat_circulation_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_target", "_item"];

_target setVariable [QGVAR(ondUse), true, true];

[{
    private _patient = _this select 0;
    [_patient, _patient] call kat_pharma_fnc_retrieveIV;
}, [_target], 300] call CBA_fnc_waitAndExecute;

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, "Ondansetron"]] call ace_medical_treatment_fnc_addToLog;
[_target, "TXA", 5, 120, 0, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;

true
