#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Local function for Epi Overdose
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_patient, "LeftArm"] call kat_pharma_fnc_treatmentAdvanced_EACALocal;
 *
 * Public: No
 */

params ["_patient"];
private _hrValue = [40, 30, 50];
private _hrAdjust = selectRandom _hrValue;
[_patient, "TACHYCARDIA", 30, 1200, _hrAdjust, "", "", "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
if (random 10 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
};