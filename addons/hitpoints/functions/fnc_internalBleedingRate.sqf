#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Gets Bleeding Rate of internal bleeding on a bodypart
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Body part
 *
 * Return Value:
 * Amount of bleeding per second
 *
 *
 * Public: No
 */

params ["_unit", "_selectionN"];
private _wounds = GET_OPEN_WOUNDS(_unit);
private _bodyPart = ALL_BODY_PARTS select _selectionN;
private _partWounds = _wounds getOrDefault [_bodyPart, []];
private _internalBleedAmount = 0;

{
    _x params ["_woundClassID", "_amountOf", "_bleeding"];
    private _classIndex = _woundClassID / 10;
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    TRACE_1("checkLimb4",_className);
    if (_className isEqualTo "InternalBleeding") then {
        _internalBleedAmount = _internalBleedAmount + (_bleeding * _amountOf);
    };
} forEach _partWounds;

_internalBleedAmount
