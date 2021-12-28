#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes Bradycardia Effect.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "Atropine"] call kat_pharma_fnc_treatmentAdvanced_AtropineLocal;
 *
 * Public: No
 */

params ["_target", "_item"];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable ["ace_medical_medications", _medicationArray, true];

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, "Atropine"]] call ace_medical_treatment_fnc_addToLog;

true
