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

params ["_patient", "_bodyPart", "_classname"];

private _medicationArray = _patient getVariable ["ace_medical_medications", []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable ["ace_medical_medications", _medicationArray, true];