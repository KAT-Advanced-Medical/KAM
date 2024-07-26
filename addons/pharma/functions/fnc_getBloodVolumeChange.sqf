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
private _lossVolumeChange = (-_deltaT * (_bloodLoss + _internalBleeding));
private _ECP = _unit getVariable [QEGVAR(circulation,ECP), 3300];
private _ECB = _unit getVariable [QEGVAR(circulation,ECB), 2700];
private _ISP = _unit getVariable [QEGVAR(circulation,ISP), 10000];
private _SRBC = _unit getVariable [QEGVAR(circulation,SRBC), 500];
private _SRBCChange = 0;

_ECP = _ECP + (_lossVolumeChange * 1000) / 2;
_ECB = _ECB + (_lossVolumeChange * 1000) / 2;

// Movement of blood from speen to stream (heh)
_SRBCChange = if(_SRBC > 100 && _ECB < 2700) then { ((2700 - _ECB) min (abs((_lossVolumeChange * 1000)) / 2 + 1)) } else { 0 };
_ECB = _ECB + _SRBCChange;

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

            if ( EGVAR(hypothermia,enable_hypothermia) ) then {
                private _incomingVolumeChange = [0,0,0,0,0,0];

                if ((_unit getVariable [QEGVAR(hypothermia,fluidWarmer), [0,0,0,0,0,0]]) select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };

            switch (true) do {
                case(_type == "Plasma"): { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / 1000); };
                case(_type == "Saline"): { _ECP = _ECP + _bagChange / 2; _ISP = _ISP + _bagChange / 2; _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000); };
                case(_type == "Blood"): { _ECB = _ECB + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / 1000); };
            };
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

// Incoming fluids impacting internal temperature
if ( EGVAR(hypothermia,enable_hypothermia) ) then {
    private _fluidHeat = 0;
    {_fluidHeat = _fluidHeat + _x} forEach _incomingVolumeChange;

    if (_fluidHeat > 0) then {
        private _totalHeat = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
        _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalHeat + _fluidHeat, _syncValues];
    } else {
        private _totalCooling = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
        _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalCooling + _fluidHeat, _syncValues];
    };
};

// Movement and recovery of interstital fluid 
private _shiftValue = 0;
switch (true) do {
    case ((_ECB + _ECP) > (_ISP * 0.6)): {
        _shiftValue = (5 min ((_ECP + _ECB) - (_ISP * 0.6)));
        _ECP = _ECP - _shiftValue;
        _ISP = _ISP + _shiftValue;
    };
    case ((_ECB + _ECP) < (_ISP * 0.6)): {
        _shiftValue = (5 min ((_ISP * 0.6) - (_ECP + _ECB)));
        _ECP = _ECP + _shiftValue;
        _ISP = _ISP - _shiftValue;
    };
    default {
        _ISP = _ISP + ((10000 - _ISP) min 2);
        _SRBC = _SRBC + ((500 - _SRBC) min 0.5);
    };
};

_unit setVariable [QEGVAR(circulation,ISP), _ISP, _syncValues];
_unit setVariable [QEGVAR(circulation,SRBC), (_SRBC - _SRBCChange), _syncValues];
_unit setVariable [QEGVAR(circulation,ECP), _ECP, _syncValues];
_unit setVariable [QEGVAR(circulation,ECB), _ECB, _syncValues];

[_lossVolumeChange, _ECP, _ECB]