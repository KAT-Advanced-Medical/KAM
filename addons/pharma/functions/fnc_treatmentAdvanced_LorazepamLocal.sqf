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

params ["_patient"];

private _random = random 3;
if (_random <= 1) then {
    private _hrValue = [-40, -30, -50];
    private _hrAdjust = selectRandom _hrValue;
    [_patient, "BRADYCARDIA", 120, 1200, _hrAdjust, 0, 0, "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
};

_patient setVariable [QEGVAR(surgery,sedated), true, true];
[_patient, true] call ACEFUNC(medical,setUnconscious);
