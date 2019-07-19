#include "script_component.hpp"
/*
 * Author: Katalam
 * Add or remove oxygen saturation with given value
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Value <NUMBER>
 * 2: Add or remove <BOOLEAN>
 *
 * Return Value:
 * 0: New value <NUMBER>
 *
 * Example:
 * [cursorTarget, 5, true] call KAM_breathing_fnc_adjustSp02;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_value", 0, [0]], ["_add", true, [true]]];

private _newValue = 0;
private _oldValue = _unit getVariable [QGVAR(status), 100];
_value = _value / 100;

if (_add) then {
    _newValue = _oldValue + _value;
    _unit setVariable [QGVAR(status), _newValue, true];
} else {
    _newValue = _oldValue - _value;
    if (_newValue < 65) then {_newValue = 65};
    _unit setVariable [QGVAR(status), _newValue, true];
};

_newValue;
