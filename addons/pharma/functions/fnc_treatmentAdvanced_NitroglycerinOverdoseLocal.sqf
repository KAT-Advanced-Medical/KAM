#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Nitroglycerin.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NitroglycerinOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
systemChat str "NitroOverdose";
private _hrValue = [-20, -25, -30, -35, -40, -45, 20, 25, 30, 35, 40, 45];
private _hrAdjust = selectRandom _hrValue;
[_patient, NitroglycerinOverdose, 30, 1200, _hrAdjust, "", 75, "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
if (random 3 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];};
