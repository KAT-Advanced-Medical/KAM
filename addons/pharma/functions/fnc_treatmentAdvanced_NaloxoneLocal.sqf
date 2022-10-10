#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes 1x Morphine after the administration of Naloxone.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Item Classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Naloxone"] call kat_pharma_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_patient"];

private _medicationArray = _patient getVariable ["ace_medical_medications", []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "Morphine" || _medication isEqualTo "Fentanyl" || _medication isEqualTo "Nalbuphine") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable ["ace_medical_medications", _medicationArray, true];