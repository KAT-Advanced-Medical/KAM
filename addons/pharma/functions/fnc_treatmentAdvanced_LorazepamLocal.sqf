#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Lorazepam sedating process
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_LorazepamLocal;
 *
 * Public: No
 */

params ["_patient", "_dose"];

private _random = random 3;
if (_random <= 1) then {
    private _hrValue = [-40, -30, -50];
    private _hrAdjust = selectRandom _hrValue;
    [_patient, "BRADYCARDIA", 120, 1200, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] call EFUNC(vitals,addMedicationAdjustment);
};
private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
private _doseNormalized = linearConversion [0, 40, _dose, 10, 30, true];
private _weightNormalized = linearConversion [60, 100, _currentWeight, 10, 30, true];
if (_doseNormalized >_weightNormalized) then {
    [_patient, "Lorazepam", 10, 600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "true"] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, true] call ACEFUNC(medical,setUnconscious);
};

