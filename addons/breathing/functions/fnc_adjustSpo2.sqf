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

params [["_unit", objNull, [objNull]], ["_value", 0, [0]], ["_add", true, [true]]];

private _newValue = 0;
private _oldValue = _unit getVariable ["KAT_medical_airwayStatus", 100];
_value = _value / 100;

if (_add) then {
    _newValue = _oldValue + _value;
    _unit setVariable ["KAT_medical_airwayStatus", _newValue, true];
	if (_newValue > 65 && (_unit getVariable ["ACE_isUnconscious",true])) then {
		[_unit, false, 0, true] call ace_medical_fnc_setUnconscious;
		diag_log "Add SPO2"
	};
} else {
    _newValue = _oldValue - _value;
    if (_newValue < 65) then {_newValue = 65};
    _unit setVariable ["KAT_medical_airwayStatus", _newValue, true];
	if (_newValue < 65 && (_unit getVariable ["ACE_isUnconscious",true])) then {
		[_unit, true] call ace_medical_fnc_setUnconscious;
		diag_log "Remove SPO2"
	};
};

if (_newValue <= 1) then {
    _unit setVariable ["KAT_medical_airwayStatus", 0, true];
    _newValue = 0;
	if (_newValue < 65 && (_unit getVariable ["ACE_isUnconscious",true])) then {
		[_unit, true] call ace_medical_fnc_setUnconscious;
		diag_log "SPO2 == 0"
	};
};

_newValue
