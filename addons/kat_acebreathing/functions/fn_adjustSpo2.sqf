/*
 * Author: Katalam
 * Handling death timer for breathing
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, CBA_missionTime] call kat_aceBreathing_fnc_handleTimer;
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
