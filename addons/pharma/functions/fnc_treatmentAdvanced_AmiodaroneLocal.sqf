#include "..\script_component.hpp"
/*
 * Author: Mazinski.H, Edited by MiszczuZPolski and Cplhardcore
 * Applies Bradycardia randomly
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_pharma_fnc_treatmentAdvanced_AmiodaroneLocal;
 *
 * Public: No
 */

private _random = random 3;
if (_random <= 1) then {
    [_patient, "BRADYCARDIA", 120, 1200, -40, 0, 0] call ACEFUNC(medical_status,addMedicationAdjustment);
};
