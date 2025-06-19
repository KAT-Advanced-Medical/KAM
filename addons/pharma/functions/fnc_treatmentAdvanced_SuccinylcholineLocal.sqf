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
private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
private _doseNormalized = linearConversion [0, 40, _dose, 10, 30, true];
private _weightNormalized = linearConversion [60, 100, _currentWeight, 10, 30, true];
if (_doseNormalized >_weightNormalized) then {
    [_patient, "Succinylcholine", 10, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "true"] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, true] call ACEFUNC(medical,setUnconscious);
};