#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the effect of Etomidate
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_EtomidateLocal;
 *
 * Public: No
 */
params ["_patient", "_dose"];

private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
private _doseNormalized = linearConversion [0, 40, _dose, 10, 30, true];
private _weightNormalized = linearConversion [60, 100, _currentWeight, 10, 30, true];
if (_doseNormalized >_weightNormalized) then {
    _patient setVariable [QGVAR(activeEtomidateLoadingDose), true, true];
    [_patient, "Etomidate", 5, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "true"] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, true] call ACEFUNC(medical,setUnconscious);
    [{
    params ["_patient"]; 
    _patient setVariable [QGVAR(activeEtomidateLoadingDose), false, true];
    }, [_patient], 180] call CBA_fnc_waitAndExecute;

};