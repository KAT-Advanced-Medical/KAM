#include "..\script_component.hpp"
/*
 * Author: Glowbal, modified by Cplhardcore
 * Update total wound bleeding based on open wounds and tourniquets
 * Wound bleeding = percentage of cardiac output lost
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call kat_circulation_fnc_updateWoundBloodLoss
 *
 * Public: No
 */

params ["_unit"];

TRACE_1("updateWoundBloodLoss",_unit);
private _tourniquets = GET_KAT_TOURNIQUETS(_unit);
private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];

private _bodyPartBleeding = [0,0,0,0,0,0,0,0,0,0,0,0];
private _bodyExternalPartBleeding = [0,0,0,0,0,0,0,0,0,0,0,0];

{
    private _partIndex = ALL_BODY_PARTS find _x;
    private _appliedPressure = GET_APPLIEDPRESSURE(_unit);
    private _pressureApplied = _appliedPressure select _partIndex;

    private _idx = _occlusionMap findIf { _x#0 == _partIndex };
    private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
    private _isOccluded = { _tourniquets select _x >= 1 } count _result > 0;
    private _occlusionLevel = if (_result isNotEqualTo []) then { selectMax (_result apply { _tourniquets select _x }) } else { 1 };
    private _isPressureApplied = _pressureApplied > 0;
    if (!_isOccluded) then {
        private _partBleeding = 0;
        {
            _x params ["_woundClassID", "_amountOf", "_bleeding"];
            private _classIndex = _woundClassID / 10;
            private _category   = _woundClassID % 10;
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
            if (_isPressureApplied || (_occlusionLevel > 0)) then {
                switch (true) do {
                    case (_suffix == "Minor"): {
                        _partBleeding = _partBleeding + ((_amountOf * _bleeding) * (_pressureApplied * 1.5) * (1 - _occlusionLevel));
                    };
                    case (_suffix == "Medium"): {
                        _partBleeding = _partBleeding + ((_amountOf * _bleeding) * _pressureApplied * (1 - _occlusionLevel));
                    };
                    case (_suffix == "Large"): {
                        _partBleeding = _partBleeding + ((_amountOf * _bleeding) * (_pressureApplied * 0.7) * (1 - _occlusionLevel));
                    };
                    default {
                        _partBleeding = _partBleeding + ((_amountOf * _bleeding) * _pressureApplied * (1 - _occlusionLevel));
                    };
                };
            } else {
                _partBleeding = _partBleeding + (_amountOf * _bleeding);
            };
            if !(_className in ["InternalBleeding"]) then {
                _bodyExternalPartBleeding set [_partIndex, _partBleeding];
                TRACE_3("updateWoundBloodLossExternal",_partBleeding,_bodyExternalPartBleeding,_partIndex);
            };
        } forEach _y;
        _bodyPartBleeding set [_partIndex, _partBleeding];
        TRACE_3("updateWoundBloodLoss",_partBleeding,_bodyPartBleeding,_partIndex);
        _unit setVariable [VAR_BODY_BLEED_RATE, _bodyExternalPartBleeding, true];
    };
} forEach GET_OPEN_WOUNDS(_unit);
if (selectMax _bodyPartBleeding == 0) exitWith {
    TRACE_1("updateWoundBloodLoss-none",_unit);
    _unit setVariable [VAR_BODY_BLEED_RATE, DEFAULT_BODY_BLEED_RATE_VALUES, true];
    _unit setVariable [VAR_WOUND_BLEEDING, 0, true];
};

_bodyPartBleeding params ["_headBleeding","_neckBleeding", "_chestBleeding", "_bodyBleeding", "_leftArmBleeding","_leftUpperArmBleeding", "_rightArmBleeding","_rightUpperArmBleeding", "_leftLegBleeding","_leftUpperLegBleeding", "_rightLegBleeding", "_rightUpperLegBleeding"];
private _bodyBleedingRate = ((_headBleeding min 0.9) + (_neckBleeding min 0.9) + (_chestBleeding min 1.0) + (_bodyBleeding min 1.0)) min 1.0;
private _limbBleedingRate = ((_leftArmBleeding min 0.3) + (_leftUpperArmBleeding min 0.3) + (_rightArmBleeding min 0.3) + (_rightUpperArmBleeding min 0.3) + (_leftLegBleeding min 0.5) + (_leftUpperLegBleeding min 0.5) + (_rightLegBleeding min 0.5) + (_rightUpperLegBleeding min 0.5)) min 1.0;


// limb bleeding is scaled down based on the amount of body bleeding
_limbBleedingRate = _limbBleedingRate * ((1 - _bodyBleedingRate) min 0.5);

TRACE_3("updateWoundBloodLoss-bleeding",_unit,_bodyBleedingRate,_limbBleedingRate);
_unit setVariable [VAR_WOUND_BLEEDING, _bodyBleedingRate + _limbBleedingRate, true];
