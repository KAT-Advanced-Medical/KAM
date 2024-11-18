#include "..\script_component.hpp"
/*
 * Author: Mazinski.H, Edited by MiszczuZPolski and Cplhardcore
 * Handles the overdose effect Amiodarone
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_pharma_fnc_treatmentAdvanced_AmiodaroneOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = -50 + floor random ((-30 - -50) + 1);
[_patient, "BRADYCARDIA", 120, 1200, _hrAdjust, "", "", "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
[_patient, "AmiodaroneOverdose", 30, 600, "", "", "", 0.2, "", ""] call EFUNC(vitals,addMedicationAdjustment);
