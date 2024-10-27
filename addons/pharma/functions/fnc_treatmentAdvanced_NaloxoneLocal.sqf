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

{
    _x params ["_medication"];
    if (_medication isEqualTo "Morphine" || _medication isEqualTo "Fentanyl" || _medication isEqualTo "Nalbuphine") then {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach _medicationArray;

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
