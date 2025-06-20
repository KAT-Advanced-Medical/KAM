#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Sedates the patient
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: bodypart
 * 2 classname
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, leftLeg, syringe_ketamine_5ml_3] call kat_pharma_fnc_treatmentAdvanced_ketamineLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_classname"];
private _parts = _classname splitString "_";
if ((count _parts) >= 2) then {
    private _lastTwo = [_parts select -2, _parts select -1];
     _isMatch = _lastTwo in [
        ["5ml", "22"],
        ["5ml", "24"],
        ["5ml", "26"],
        ["5ml", "28"],
        ["5ml", "30"]
    ];
};
private _timeInSystem = linearConversion [22, 30, (_parts select -1), 60, 300];
if (_isMatch) then {
    [_patient, "Ketamine", 10, _timeInSystem, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "true"] call EFUNC(vitals,addMedicationAdjustment);
[_patient, true] call ACEFUNC(medical,setUnconscious);
};
