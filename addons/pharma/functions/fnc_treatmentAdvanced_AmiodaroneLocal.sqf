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

private _cardiacRhythm = _patient getVariable [QEGVAR(circulation,cardiacArrestType), 0];
_patient setVariable [QEGVAR(circulation,cardiacArrestType), 1];
[{ 
    params ["_patient", "_cardiacRhythm"];
    _patient setVariable [QEGVAR(circulation,cardiacArrestType), _cardiacRhythm];
}, [_patient, _cardiacRhythm], random(8) + 8] call CBA_fnc_waitAndExecute;
private _random = random 3;
if (_random <= 1) then {
    [_patient, "BRADYCARDIA", 120, 1200, -40, 0, 0] call ACEFUNC(medical_status,addMedicationAdjustment);
};
