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

params [["_unit", objNull, [objNull]]];

if !(kat_aceBreathing_enable) exitWith {};

if (!local _unit) then {
	["handleBreathing", [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
	params ["_args", "_idPFH"];
	_args params ["_unit"];
	if !(alive _unit) exitWith {
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};
	if ([_unit] call ace_common_fnc_isAwake) exitWith {
		[_unit, CBA_missionTime] call kat_aceBreathing_fnc_handleTimerAlive;
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};

	private _o2 = _unit getVariable ["kat_aceBreathing_o2", false];
	private _occluded = _unit getVariable ["ace_medical_airwayOccluded", false];
	private _collapsed = _unit getVariable ["ace_medical_airwayCollapsed", false];

	if (_unit getVariable ["ace_medical_heartRate", 0] > 0) exitWith {
		if (_occluded || _collapsed) exitWith {
		    [_unit, kat_aceBreathing_spo2_small_value, false] call kat_aceBreathing_fnc_adjustSpo2;
		};
	    if (_o2) then {
	        [_unit, kat_aceBreathing_spo2_big_value, true] call kat_aceBreathing_fnc_adjustSpo2;
	    } else {
			[_unit, kat_aceBreathing_spo2_small_value, true] call kat_aceBreathing_fnc_adjustSpo2;
		};
	};

	private _overstretch = _unit getVariable ["kat_aceAirway_overstretch", false];
	private _airwaySafed = _unit getVariable ["kat_aceAirway_airway", false];

	switch (true) do {
	    case (_overstretch && !_occluded): {
	        [_unit, kat_aceBreathing_spo2_small_value, true] call kat_aceBreathing_fnc_adjustSpo2;
	    };
		case (_overstretch && _o2 && !_occluded): {
		    [_unit, kat_aceBreathing_spo2_big_value, true] call kat_aceBreathing_fnc_adjustSpo2;
		};
		case (_airwaySafed && _o2): {
		    [_unit, kat_aceBreathing_spo2_big_value, true] call kat_aceBreathing_fnc_adjustSpo2;
		};
		default {
		    [_unit, kat_aceBreathing_spo2_small_value, false] call kat_aceBreathing_fnc_adjustSpo2;
		};
	};

	if (kat_aceBreathing_death_timer_enable) then {
		if (_unit getVariable ["ace_medical_airwayStatus", 100] <= 5) exitWith {
			[_idPFH] call CBA_fnc_removePerFrameHandler;
			[_unit, true] call ace_medical_fnc_setDead;
		};
	};
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
