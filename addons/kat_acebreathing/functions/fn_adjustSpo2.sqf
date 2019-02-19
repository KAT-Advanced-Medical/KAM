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
 * None
 *
 * Example:
 * [cursorTarget, 5, true] call kat_aceBreathing_fnc_adjustSp02;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_value", 0, [0]], ["_add", true, [true]]];

private _newValue = 0;

if (_add) then {
	_newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) + _value;
	_unit setVariable ["ace_medical_airwayStatus", _newValue, true];
} else {
	_newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) - _value;
	_unit setVariable ["ace_medical_airwayStatus", _newValue, true];
};

if (_newValue <= 1) then {
	_unit setVariable ["ace_medical_airwayStatus", 0, true];
	_newValue = 0;
};

_newValue;
