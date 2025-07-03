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
private _lastTwo = [_parts select -2, _parts select -1];
private _isMatch = _lastTwo in [
    ["5ml", "22"],
    ["5ml", "24"],
    ["5ml", "26"],
    ["5ml", "28"],
    ["5ml", "30"]
];

systemChat str _classname;
systemChat str _parts;
systemChat str _lastTwo;
systemChat str _isMatch;
if (_isMatch) then {
    private _timeInSystem = linearConversion [22, 30, (parseNumber (_parts select -1)), 60, 300];
    [_patient, "Ketamine", 10, _timeInSystem, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "true"] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, true] call ACEFUNC(medical,setUnconscious);
};
