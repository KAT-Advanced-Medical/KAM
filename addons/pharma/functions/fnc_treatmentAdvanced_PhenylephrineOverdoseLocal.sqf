#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Phenylephrine
 *
 * Arguments:
 * 0: Patient <OBJECT>

 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_PhenylephrineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrValue = [20, 25, 30, 35, 40, 45];
private _hrAdjust = selectRandom _hrValue;
private _alphaValue = [-0.7, -0.6, -0.8];
private _alphaAdjust = selectRandom _alphaValue;
[_patient, "PhenylephrineOverdose", 30, 1200, _hrAdjust, 0, 0, 0, _alphaAdjust] call EFUNC(vitals,addMedicationAdjustment);
if (random 5 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
};