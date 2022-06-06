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
private _bagChange = 0;
private _bloodBags = _unit getVariable ["ace_medical_ivBags", []];

if !(_bloodBags isEqualTo []) then {
    private _firstBag = _bloodBags select 0;
    _firstBag params ["_bagVolumeRemaining", "_type", "_bodyPart"];

    if (GET_TOURNIQUETS(_unit) select _bodyPart != 0) exitWith {};

    if (_unit getVariable [QGVAR(IVblock), false]) exitWith {};

    private _count = (count _bloodBags) min GVAR(maxStack);
    private _flow = ace_medical_ivFlowRate;
    private _alpha = _unit getVariable [QGVAR(alphaAction), 1];
    private _ph = _unit getVariable [QGVAR(ph), 1000];

    if (GET_HEART_RATE(_unit) < 20) then {
        _flow = _flow / 2;
    };

    _bagChange = (_deltaT * _flow * 4.16 * _alpha * _count) min _bagVolumeRemaining; // absolute value of the change in miliLiters

    if (_type isEqualTo "Saline") then {
        _ph = (_ph - _bagChange) max 0;
        _unit setVariable [QGVAR(ph), _ph, true];
    } else {
        _ph = (_ph + _bagChange) min 1000;
        _unit setVariable [QGVAR(ph), _ph, true];

        _bagChange = _bagChange * 0.8;
    };

    _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;

    if (_bagVolumeRemaining < 0.01) then {
        _bloodBags deleteAt 0;
        if (_bloodBags isEqualTo []) then {
            _unit setVariable ["ace_medical_ivBags", nil, true]; // no bags left - clear variable (always globaly sync this)
        };
    } else {
        _bloodBags set [0, [_bagVolumeRemaining, _type, _bodyPart]];
        _unit setVariable ["ace_medical_ivBags", _bloodBags, _syncValues];
    };
};

_bloodVolumeChange + (_bagChange / 1000)