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
private _hrAdjust = -20 + floor random ((-20 - -40) + 1);
[_patient, "MetoprololOverdose", 60, 600, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, -0.2] call EFUNC(vitals,addMedicationAdjustment);