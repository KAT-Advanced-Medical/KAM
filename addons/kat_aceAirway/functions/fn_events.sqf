/*
 * Author: Katalam
 * CBA Events function - Post Init
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceAirway_fnc_events;
 *
 * Public: No
 */

if !(kat_aceAirway_enable) exitWith {};

["treatmentLarynx", {_this call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal}] call CBA_fnc_addEventHandler;
["treatmentAirway", {_this call kat_aceAirway_fnc_treatmentAdvanced_airwayLocal}] call CBA_fnc_addEventHandler;
["treatmentGuedel", {_this call kat_aceAirway_fnc_treatmentAdvanced_guedelLocal}] call CBA_fnc_addEventHandler;
["treatmentAccuvac", {_this call kat_aceAirway_fnc_treatmentAdvanced_accuvacLocal}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
    params ["_unit", "_state"];
    if !(_state) exitWith {
        _unit call kat_aceAirway_fnc_init;
    };
    if (_unit getVariable [kat_aceAirway_string_exit, false]) exitWith {};
    if (kat_aceBreathing_enable) then {
        ["deathTimerBreathing", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
    };
    [_unit] call kat_aceAirway_fnc_handleAirway;
    [_unit] call kat_aceAirway_fnc_handlePuking;
}] call CBA_fnc_addEventHandler;

["deathTimerAirway", {_this call kat_aceAirway_fnc_handleTimer}] call CBA_fnc_addEventHandler;
["ace_treatmentSucceded",{
    params ["", "_target", "", "_className"];
    if (toUpper _className isEqualTo "PERSONALAIDKIT" && local _target) exitWith {
    	_target call kat_aceAirway_fnc_init;
    };
 }] call CBA_fnc_addEventHandler;
