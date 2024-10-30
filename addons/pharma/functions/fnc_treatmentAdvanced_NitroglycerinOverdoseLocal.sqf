#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes one opioid after the administration of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */
 params ["_patient"];
private _hrValue = [-20, -25, -30, -35, -40, -45, 20, 25, 30, 35, 40, 45];
private _hrAdjust = selectRandom _hrValue;
[_patient, NitroglycerinOverdose, 30, 1200, _hrAdjust, "", 75, "", "", ""] call EFUNC(vitals,addMedicationAdjustment);