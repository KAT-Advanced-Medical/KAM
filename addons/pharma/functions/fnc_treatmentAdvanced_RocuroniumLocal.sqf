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
params ["_patient", "_dose", "_timeTillMaxEffect", "_timeInSystem"];
private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
private _doseNormalized = linearConversion [0, 40, _dose, 10, 30, true];
private _weightNormalized = linearConversion [60, 100, _currentWeight, 10, 30, true];
if (_doseNormalized > _weightNormalized) then {
    [_patient, "Rocuronium", _timeTillMaxEffect, _timeInSystem, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "false", "true"] call EFUNC(vitals,addMedicationAdjustment);
};