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

params [["_unit", objNull, [objNull]]];

if !(GVAR(enable)) exitWith {};

if (!local _unit) then {
    ["handleBreathing", [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _collapsed = _unit getVariable ["KAT_medical_airwayCollapsed", false];
    private _status = _unit getVariable ["KAT_medical_airwayStatus", 50];

    if ([_unit] call ace_common_fnc_isAwake && !_collapsed) exitWith {
        if (_status >= 100) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
    };

    if (_status > 100) exitWith {
        _unit setVariable ["KAT_medical_airwayStatus", 100, true];
		if (_unit getVariable ["ACE_isUnconscious",true]) then {
			[_unit, false, 0, true] call ace_medical_fnc_setUnconscious;
			diag_log "HandleBreathing: Unit now not unconscious!"
		};
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _o2 = _unit getVariable [QGVAR(o2), false];
    private _occluded = _unit getVariable ["KAT_medical_airwayOccluded", false];
    private _obstruction = _unit getVariable [QEGVAR(airway,obstruction), false];

    if (_collapsed) exitWith {
        [_unit, GVAR(spo2_big_value), false] call FUNC(adjustSpo2);
    };

    if (_unit getVariable ["ace_medical_heartRate", 0] > 0) exitWith {
        if (_occluded || _obstruction) exitWith {
            [_unit, GVAR(spo2_small_value), false] call FUNC(adjustSpo2);
        };
        if (_o2) then {
            [_unit, GVAR(spo2_big_value), true] call FUNC(adjustSpo2);
        } else {
            [_unit, GVAR(spo2_small_value), true] call FUNC(adjustSpo2);
        };
    };

    private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
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

    if (GVAR(death_timer_enable)) then {
        if (_status <= 5) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            [_unit, true] call ace_medical_fnc_setDead;
        };
    };
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
