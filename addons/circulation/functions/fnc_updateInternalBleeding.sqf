#include "..\script_component.hpp"
/*
 * Author: Blue
 * Updates internal bleeding rate.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Is Healed <BOOL>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, false] call kat_circulation_fnc_updateInternalBleeding
 *
 * Public: No
 */

params ["_unit", ["_heal", false]];

private _cardiacOutput = [_unit] call ACEFUNC(medical_status,getCardiacOutput);
private _alphaAction = GET_VASOCONSTRICTION(_unit);
private _internalBleeding = 0;

if !(_heal) then {
    if (_unit getVariable [QEGVAR(breathing,hemopneumothorax), false]) then {
        _internalBleeding = _internalBleeding + EGVAR(breathing,HPTXBleedAmount);
    };
};

_unit setVariable [VAR_INTERNAL_BLEEDING, _internalBleeding * (_cardiacOutput max 0.05) * ACEGVAR(medical,bleedingCoefficient) * _alphaAction, true];
