#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = 20 + floor random ((50 - 20) + 1);
[_patient, "RocuroniumOverdose", 60, 300, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, (random [-0.7, -0.3]), 0, 0, "false"] call EFUNC(vitals,addMedicationAdjustment);
