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
 * [player, syringe_kat_atropine_5ml_2] call kat_pharma_fnc_treatmentAdvanced_AtropineLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_classname"];

if (_classname isEqualTo "syringe_kat_atropine_5ml_3") exitWith {};

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
