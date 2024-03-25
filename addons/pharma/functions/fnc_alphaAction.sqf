#include "..\script_component.hpp"
/*
 * Author: MJSTIC
 * Adds the alpha factor value from medications to the patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Alpha Value <NUMBER>
 *
 * Example:
 * [player, 0.5] call kat_pharma_fnc_alphaAction;
 *
 * Public: No
 */

params ["_patient", "_value"];

private _alphaAction = _patient getVariable [QGVAR(alphaAction), 1];

_alphaAction = _alphaAction + _value;

_alphaAction = (_alphaAction min 2) max 0.5;

ACEGVAR(medical,const_minCardiacOutput) = _alphaAction * EGVAR(circulation,cardiacArrestBleedRate);
_patient setVariable [QGVAR(alphaAction), _alphaAction, true];
