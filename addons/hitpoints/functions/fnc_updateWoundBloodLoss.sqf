#include "..\script_component.hpp"
/*
 * Author: Glowbal
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
 * [player] call ace_medical_status_fnc_updateWoundBloodLoss
 *
 * Public: No
 */

params ["_unit"];

TRACE_1("updateWoundBloodLoss",_unit);
private _tourniquets = GET_TOURNIQUETS(_unit);
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
private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _appliedPressure = GET_APPLIEDPRESSURE(_patient);
private _pressureApplied = _appliedPressure select _part;

{
    private _partIndex = ALL_BODY_PARTS find _x;

    private _idx = _occlusionMap findIf { _x#0 == _partIndex };
    private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
    private _isOccluded = { _tourniquets select _x != 0 } count _result > 0;

    private _hasPressureApplied = { _pressureApplied select _x != 0 } count _result > 0;
    if (!_isOccluded) then {
        private _partBleeding = 0;
        {
            _x params ["", "_amountOf", "_bleeding"];
            if (_hasPressureApplied) then {
                _partBleeding = _partBleeding + ((_amountOf * _bleeding) * _pressureApplied);
            } else {
                _partBleeding = _partBleeding + (_amountOf * _bleeding);
            }
            
        } forEach _y;
        _bodyPartBleeding set [_partIndex, _partBleeding];
        TRACE_1("updateWoundBloodLoss",_partBleeding);
    };
} forEach GET_OPEN_WOUNDS(_unit);
if (selectMax _bodyPartBleeding == 0) exitWith {
    TRACE_1("updateWoundBloodLoss-none",_unit);
    _unit setVariable [VAR_WOUND_BLEEDING, 0, true];
};

_bodyPartBleeding params ["_headBleeding","_neckBleeding", "_chestBleeding", "_bodyBleeding", "_leftArmBleeding","_leftUpperArmBleeding", "_rightArmBleeding","_rightUpperArmBleeding", "_leftLegBleeding","_leftUpperLegBleeding", "_rightLegBleeding", "_rightUpperLegBleeding"];
private _bodyBleedingRate = ((_headBleeding min 0.9) + (_neckBleeding min 0.9) + (_chestBleeding min 1.0) + (_bodyBleeding min 1.0)) min 1.0;
private _limbBleedingRate = ((_leftArmBleeding min 0.3) + (_leftUpperArmBleeding min 0.3) + (_rightArmBleeding min 0.3) + (_rightUpperArmBleeding min 0.3) + (_leftLegBleeding min 0.5) + (_leftUpperLegBleeding min 0.5) + (_rightLegBleeding min 0.5) + (_rightUpperLegBleeding min 0.5)) min 1.0;


// limb bleeding is scaled down based on the amount of body bleeding
_limbBleedingRate = _limbBleedingRate * (1 - _bodyBleedingRate);

TRACE_3("updateWoundBloodLoss-bleeding",_unit,_bodyBleedingRate,_limbBleedingRate);
_unit setVariable [VAR_WOUND_BLEEDING, _bodyBleedingRate + _limbBleedingRate, true];
