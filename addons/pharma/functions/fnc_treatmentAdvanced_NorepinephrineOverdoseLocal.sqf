#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes Bradycardia Effect.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NorepinephrineLocal;
 *
 * Public: No
 */
 params ["_patient"];
private _hrValue = [40, 30, 50];
private _hrAdjust = selectRandom _hrValue;
[_patient, "TACHYCARDIA", 120, 1200, _hrAdjust, "", "", "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
if (random 10 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm];
};