#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes one opioid after the administration of Naloxone.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];
private _medicationDeleted = false;
private _ht = _patient getVariable [QEGVAR(circulation,ht), []];

{
    _x params ["_medication"];
    private _lowerMed = toLower _medication;
    if (
        (_lowerMed find "morphine" != -1) ||
        (_lowerMed find "morphineOverdose" != -1) ||
        (_lowerMed find "fentanyl" != -1) ||
        (_lowerMed find "fentanylOverdose" != -1) ||
        (_lowerMed find "nalbuphine" != -1) ||
        (_lowerMed find "nalbuphineOverdose" != -1)
    ) then {
        if (random 1 < 0.33) then {
            _medicationArray deleteAt (_medicationArray find _x);
            _medicationDeleted = true;
            _patient setVariable [QEGVAR(pharma,opioidFactor), 1];
            _ht deleteAt (_ht find "opioidOD");
            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
        };
    };
} forEach _medicationArray;

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
