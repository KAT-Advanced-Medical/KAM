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
 * [player] call kat_pharma_fnc_treatmentAdvanced_NorepinephrineLocal;
 *
 * Public: No
 */
params ["_patient", "_classname"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];