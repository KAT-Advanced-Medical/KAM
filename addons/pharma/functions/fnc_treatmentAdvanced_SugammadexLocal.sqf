#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];
    private _lowerMed = toLower _medication;
    if (
        (_lowerMed find "rocuronium" != -1) ||
        (_lowerMed find "rocuroniumoverdose" != -1)
        
    ) then {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach _medicationArray;

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];