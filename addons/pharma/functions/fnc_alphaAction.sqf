#include "..\script_component.hpp"
/*
 * Author: Mazinski
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

if (_alphaAction > 2) exitWith {
    _alphaAction = 2;
    _patient setVariable [QGVAR(alphaAction), _alphaAction, true];
};

if (_alphaAction < 0.5) exitWith {
    _alphaAction = 0.5;
    _patient setVariable [QGVAR(alphaAction), _alphaAction, true];
};

_patient setVariable [QGVAR(alphaAction), _alphaAction, true];
