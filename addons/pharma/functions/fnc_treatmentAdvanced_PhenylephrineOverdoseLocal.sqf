#include "..\script_component.hpp"
/*
 * Author: Blue
 * Begins Penthrox Inhaler use
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", classname, objNull, "kat_Penthrox"] call kat_pharma_fnc_treatmentAdvanced_Penthrox;
 *
 * Public: No
 */
params ["_patient"];
private _hrValue = [20, 25, 30, 35, 40, 45];
private _hrAdjust = selectRandom _hrValue;
private _alphaValue = [-0.7, -0.6, -0.8];
private _alphaAdjust = selectRandom _alphaValue;
[_patient, PhenylephrineOverdose, 30, 1200, _hrAdjust, "", "", _alphaAdjust, "", ""] call EFUNC(vitals,addMedicationAdjustment);
if (random 5 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
};