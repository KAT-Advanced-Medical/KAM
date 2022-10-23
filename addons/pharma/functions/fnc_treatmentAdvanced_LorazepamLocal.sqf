#include "script_component.hpp"
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
    [_patient, "BRADYCARDIA", 120, 1200, -40, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;
};

_patient setVariable [QEGVAR(surgery,sedated), true, true];
[_patient, true] call ace_medical_fnc_setUnconscious;