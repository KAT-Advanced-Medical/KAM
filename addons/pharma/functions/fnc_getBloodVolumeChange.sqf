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
 * [player, 1, true] call kat_pharma_fnc_getBloodVolumeChange
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _bloodLoss = [_unit] call ACEFUNC(medical_status,getBloodLoss);
private _internalBleeding = GET_INTERNAL_BLEEDING(_unit);
private _lossVolumeChange = (-_deltaT * ((_bloodLoss + _internalBleeding * (GET_HEART_RATE(_unit) / 80)) / GET_VASOCONSTRICTION(_unit)));
private _fluidVolume = GET_BODY_FLUID(_unit);
private _IVflow = _unit getVariable [QGVAR(IVflow), [0,0,0,0,0,0]];
private _ECB = _fluidVolume select 0;
private _ECP = _fluidVolume select 1;
private _SRBC = _fluidVolume select 2;
private _ISP = _fluidVolume select 3;
private _SRBCChange = 0;

_ECP = _ECP + (_lossVolumeChange * LITERS_TO_ML) / 2;
_ECB = _ECB + (_lossVolumeChange * LITERS_TO_ML) / 2;

_SRBCChange = if(_SRBC > 100 && _ECB < DEFAULT_ECB) then { ((DEFAULT_ECB - _ECB) min (abs((_lossVolumeChange * LITERS_TO_ML)) / 2 + 1)) } else { 0 };
_ECB = _ECB + _SRBCChange;

if (!isNil {_unit getVariable [QACEGVAR(medical,ivBags),[]]}) then {
    private _bloodBags = _unit getVariable [QACEGVAR(medical,ivBags), []];
    private _tourniquets = GET_TOURNIQUETS(_unit);
    private _IVarray = _unit getVariable [QGVAR(IV), [0,0,0,0,0,0]];
    private _flowCalculation = (ACEGVAR(medical,ivFlowRate) * _deltaT * 4.16);
    private _hypothermia = EGVAR(hypothermia,hypothermia);

    if (GET_HEART_RATE(_unit) < 20) then {
        _flowCalculation = _flowCalculation / 1.5;
    };

    if (_hypothermia) then {
        private _incomingVolumeChange = [0,0,0,0,0,0];
        private _fluidWarmer = _unit getVariable [QEGVAR(hypothermia,fluidWarmer), [0,0,0,0,0,0]];
        private _fluidHeat = 0;
    };

    _bloodBags = _bloodBags apply {
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart"];

        if ((_tourniquets select _bodyPart isEqualTo 0) && (_IVarray select _bodyPart isNotEqualTo 3)) then {
            private _bagChange = (_flowCalculation * (_IVflow select _bodyPart)) min _bagVolumeRemaining; // absolute value of the change in miliLiters
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;

            if (_hypothermia) then {
                // If fluid warmers are on the line, fluids are "warmed" and added to the warmer. If there is no fluid warmer on the line, the fluids stayed cooled
                if (_fluidWarmer select _bodyPart == 1) then {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) + _bagChange)];
                } else {
                    _incomingVolumeChange set [_bodyPart, ((_incomingVolumeChange select _bodyPart) - _bagChange)];
                };
            };

            // Plasma adds to ECP. Saline splits between the ECP and ISP. Blood adds to ECB
            switch (true) do {
                case(_type == "Plasma"): { _ECP = _ECP + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
                case(_type == "Saline"): { _ECP = _ECP + _bagChange / 2; _ISP = _ISP + _bagChange / 2; _lossVolumeChange = _lossVolumeChange + (_bagChange / 2000); };
                case(_type == "Blood"): { _ECB = _ECB + _bagChange; _lossVolumeChange = _lossVolumeChange + (_bagChange / ML_TO_LITERS); };
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

        // Incoming fluids impacting internal temperature
    if (_hypothermia) then {
        {_fluidHeat = _fluidHeat + _x} forEach _incomingVolumeChange;

        if (_fluidHeat > 0) then {
            private _totalHeat = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
            _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalHeat + _fluidHeat, _syncValues];
        } else {
            private _totalCooling = _unit getVariable [QEGVAR(hypothermia,warmingImpact), 0];
            _unit setVariable [QEGVAR(hypothermia,warmingImpact), _totalCooling + _fluidHeat, _syncValues];
        };
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
        // If no shift is required, fluids begin returning to baseline in both ISP and SRBC volumes
        _ISP = _ISP + ((DEFAULT_ISP - _ISP) min 2);
        _SRBC = _SRBC + ((DEFAULT_SRBC - _SRBC) min 1);
    };
};

_unit setVariable [QEGVAR(circulation,bodyFluid), [_ECB, _ECP, (_SRBC - _SRBCChange), _ISP, (_ECB + _ECP)], _syncValues];

((_lossVolumeChange + GET_BLOOD_VOLUME_LITERS(_unit)) max 0.01)