#include "script_component.hpp"
/*
 * Author: Glowbal
 * Calculate the total blood loss of a unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * Total blood loss of unit (litres/second) <NUMBER>
 *
 * Example:
 * [player] call ace_medical_status_fnc_getBloodLoss
 *
 * Public: No
 */

params ["", "_patient", "_value"];

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
