#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Pharma-side ATNAA local handler. Mirrors the atropine handler — clears any
 * BRADYCARDIA medication entry on the patient (atropine component of the
 * combined auto-injector). The chemical-side handler (kat_chemical_fnc_
 * treatmentAdvanced_AtnaaLocal) clears nerveAgentExposure separately.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_patient"];

private _medicationArray = _patient getVariable [QACEGVAR(medical,medications), []];

{
    _x params ["_medication"];

    if (_medication isEqualTo "BRADYCARDIA") exitWith {
        _medicationArray deleteAt (_medicationArray find _x);
    };
} forEach (_medicationArray);

_patient setVariable [QACEGVAR(medical,medications), _medicationArray, true];
