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
 * [cursorTarget, 5, true] call kat_breathing_fnc_adjustSp02;
 *
 * Public: No
 */

params [
    ["_unit", objNull, [objNull]],
    ["_value", 0, [0]],
    ["_add", true, [true]]
];

private _newValue = 0;
private _oldValue = _unit getVariable ["KAT_medical_airwayStatus", 100];

if (_add) then {
    _value = _value / 200;
    _newValue = _oldValue + _value;
    if (_newValue > 100) then {_newValue = 100.3};
    _unit setVariable ["KAT_medical_airwayStatus", _newValue, true];
} else {
    _value = _value / 100;
    _newValue = _oldValue - _value;
    if (_newValue <= 0) then {_newValue = 0};
    _unit setVariable ["KAT_medical_airwayStatus", _newValue, true];
};

if (!(_unit getVariable ["ACE_isUnconscious",false]) && {_newValue <= 75}) then {
    ["ace_medical_CriticalVitals", _unit] call CBA_fnc_localEvent;
};

_newValue
