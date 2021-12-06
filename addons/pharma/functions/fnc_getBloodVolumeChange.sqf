#include "script_component.hpp"
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

private _bloodLoss = [_unit] call ace_medical_status_fnc_getBloodLoss;
private _bloodVolumeChange = -_deltaT * _bloodLoss;

if (!isNil {_unit getVariable ["ace_medical_ivBags",[]]}) then {
    private _bloodBags = _unit getVariable ["ace_medical_ivBags", []];
    private _tourniquets = GET_TOURNIQUETS(_unit);
    private _flow = ace_medical_ivFlowRate;
    private _pulse = GET_HEART_RATE(_unit);

    if (_pulse < 20) then {
        _flow = 0;
    };

    _bloodBags = _bloodBags apply {
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart"];

        if (_tourniquets select _bodyPart == 0) then {
            private _bagChange = (_deltaT * _flow * 4.16) min _bagVolumeRemaining; // absolute value of the change in miliLiters
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
        _unit setVariable ["ace_medical_ivBags", nil, true]; // no bags left - clear variable (always globaly sync this)
    } else {
        _unit setVariable ["ace_medical_ivBags", _bloodBags, _syncValues];
    };
};

_bloodVolumeChange