#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Applies Norepinephrine Overdose Effects
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NorepinephrineOverdoseLocal;
 *
 * Public: No
 */
 params ["_patient"];
private _hrAdjust = 30 + floor random ((50 - 30) + 1);
[_patient, "TACHYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
if (random 10 < 1) then {
    private _randomValue = [3, 4];
    private _randomRhythm = selectRandom _randomValue;
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _randomRhythm, true];
};