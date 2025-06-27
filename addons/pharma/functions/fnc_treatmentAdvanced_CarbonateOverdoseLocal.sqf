#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CarbonateOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = 10 + floor random ((30 - 10) + 1);
[_patient, "CarbonateOverdose", 5, 360, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
