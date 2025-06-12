#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Pervatin
 *
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_PervitinOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _randomNumber = floor (random 3) + 1;
switch (_randomNumber) do {
    case 1: {
        private _bpAdjust = 20 + floor random ((35 - 20) + 1);
        [_patient, _bpAdjust, _bpAdjust, "PervitinOverdose"] call EFUNC(circulation,updateBloodPressureChange);
        private _hrAdjust = 30 + floor random ((50 - 30) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] call EFUNC(vitals,addMedicationAdjustment);
    };
    case 2: {
        private _bpAdjust = 20 + floor random ((35 - 20) + 1);
        [_patient, _bpAdjust, _bpAdjust, "PervitinOverdose"] call EFUNC(circulation,updateBloodPressureChange);
        private _hrAdjust = 30 + floor random ((50 - 30) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] call EFUNC(vitals,addMedicationAdjustment);
        private _randomValue = [3, 4];
        private _randomRhythm = selectRandom _randomValue;
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
    };
    case 3: {
        private _bpAdjust = 20 + floor random ((35 - 20) + 1);
        [_patient, _bpAdjust, _bpAdjust, "PervitinOverdose"] call EFUNC(circulation,updateBloodPressureChange);
        private _hrAdjust = 30 + floor random ((50 - 30) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] call EFUNC(vitals,addMedicationAdjustment);
        private _randomValue = [3, 4];
        private _randomRhythm = selectRandom _randomValue;
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
    };
    case 4: {
        private _bpAdjust = 20 + floor random ((35 - 20) + 1);
        [_patient, _bpAdjust, _bpAdjust, "PervitinOverdose"] call EFUNC(circulation,updateBloodPressureChange);
        private _hrAdjust = 30 + floor random ((50 - 30) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] call EFUNC(vitals,addMedicationAdjustment);
        _patient setVariable [QEGVAR(circulation,cardiacArrestType), 0];
    };
};