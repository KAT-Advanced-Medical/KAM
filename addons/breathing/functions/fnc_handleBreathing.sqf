#include "script_component.hpp"
/*
 * Author: Katalam
 * Handling oxygen saturation for breathing
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_breathing_fnc_handleBreathing;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(enable)) exitWith {};

if (_unit getVariable ["kat_O2Breathing_PFH", false]) exitWith {};
_unit setVariable ["kat_O2Breathing_PFH", true];

if (!local _unit) then {
    ["handleBreathing", [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
		_unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    private _pneumothorax = _unit getVariable ["KAT_medical_pneumothorax", false];
    private _hemothorax = _unit getVariable ["KAT_medical_hemopneumothorax", false];
    private _status = _unit getVariable ["KAT_medical_airwayStatus", 50];
    if ([_unit] call ace_common_fnc_isAwake && !_pneumothorax && !_hemothorax) exitWith {
        if (_status >= 100) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
			_unit setVariable ["kat_O2Breathing_PFH", nil];
        };
        [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
    };

	if (_status > 100) exitWith {
        _unit setVariable ["KAT_medical_airwayStatus", 100, true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
		_unit setVariable ["kat_O2Breathing_PFH", nil];
    };

    private _o2 = _unit getVariable [QGVAR(o2), false];
    private _occluded = _unit getVariable ["KAT_medical_airwayOccluded", false];
    private _obstruction = _unit getVariable [QEGVAR(airway,obstruction), false];
    private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];

    if (_pneumothorax) then {
        [_unit, GVAR(spo2_big_value), false] call FUNC(adjustSpo2);
    };

    if (_hemothorax) then {
        [_unit, GVAR(spo2_small_value), false] call FUNC(adjustSpo2);
    };

    if (_unit getVariable ["ace_medical_heartRate", 0] > 0) exitWith {
        if (_overstretch && !_occluded) exitWith {
            [_unit, GVAR(spo2_small_value), true] call FUNC(adjustSpo2);
        };
        if (_occluded || _obstruction) exitWith {
            [_unit, GVAR(spo2_small_value), false] call FUNC(adjustSpo2);
        };
        if (_o2) then {
            [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
        } else {
            [_unit, GVAR(spo2_small_value), true] call FUNC(adjustSpo2);
        };
    };

    private _airwaySafed = _unit getVariable [QEGVAR(airway,airway), false];

    switch (true) do {
        case (_overstretch && !_occluded): {
            [_unit, GVAR(spo2_small_value), true] call FUNC(adjustSpo2);
        };
        case (_overstretch && _o2 && !_occluded): {
            [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
        };
        case (_airwaySafed && _o2): {
            [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
        };
        case (_airwaySafed && !_o2): {
            [_unit, GVAR(spo2_small_value), true] call FUNC(adjustSpo2);
        };
        default {
            [_unit, GVAR(spo2_small_value), false] call FUNC(adjustSpo2);
        };
    };

    _status = _unit getVariable ["KAT_medical_airwayStatus", 50];

    if (_status <= GVAR(SpO2_dieValue)) exitWith {
      [_idPFH] call CBA_fnc_removePerFrameHandler;
      [_unit, "#setDead"] call ace_medical_status_fnc_setDead;
	    _unit setVariable ["kat_O2Breathing_PFH", nil];
    };

}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
