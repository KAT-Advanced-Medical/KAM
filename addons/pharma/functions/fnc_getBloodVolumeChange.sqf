#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Calculates the blood volume change and decreases the IVs given to the unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Global Sync Values (bloodbags) <BOOL>
 *
 * Return Value:
 * Blood volume change (liters per second) <NUMBER>
 *
 * Example:
 * [player, 1, true] call ace_medical_status_fnc_getBloodVolumeChange
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _bloodLoss = [_unit] call ACEFUNC(medical_status,getBloodLoss);
private _internalBleeding = GET_INTERNAL_BLEEDING(_unit);
private _bloodVolumeChange = -_deltaT * (_bloodLoss + _internalBleeding);

if (!isNil {_unit getVariable [QACEGVAR(medical,ivBags),[]]}) then {
    private _bloodBags = _unit getVariable [QACEGVAR(medical,ivBags), []];
    private _tourniquets = GET_TOURNIQUETS(_unit);
    private _IVarray = _unit getVariable [QGVAR(IV), [0,0,0,0,0,0]];
    private _flowCalculation = ACEGVAR(medical,ivFlowRate) * (_unit getVariable [QGVAR(alphaAction), 1]) * _deltaT * 4.16;

    if (GET_HEART_RATE(_unit) < 20) then {
        _flowCalculation = _flowCalculation / 1.5;
    };

    _bloodBags = _bloodBags apply {
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart"];

        if ((_tourniquets select _bodyPart isEqualTo 0) && (_IVarray select _bodyPart isNotEqualTo 3)) then {
            private _bagChange = _flowCalculation min _bagVolumeRemaining; // absolute value of the change in miliLiters
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _bloodVolumeChange = _bloodVolumeChange + (_bagChange / 1000);
        };

        if (_bagVolumeRemaining < 0.01) then {
            []
        } else {
            [_bagVolumeRemaining, _type, _bodyPart]
        };
    };

    _bloodBags = _bloodBags - [[]]; // remove empty bags

    if (_bloodBags isEqualTo []) then {
        _unit setVariable [QACEGVAR(medical,ivBags), nil, true]; // no bags left - clear variable (always globaly sync this)
    } else {
        _unit setVariable [QACEGVAR(medical,ivBags), _bloodBags, _syncValues];
    };
};

_bloodVolumeChange
