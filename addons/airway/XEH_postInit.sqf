#include "script_component.hpp"

if !(GVAR(enable)) exitWith {};

["treatmentAirway", {_this call FUNC(treatmentAirwayLocal)}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
    params ["_unit", "_state"];
    if !(_state) exitWith {
        _unit call FUNC(init);
    };
    if (_unit getVariable [GVAR(string_exit), false]) exitWith {};
    if (EGVAR(breathing,enable)) then {
        ["handleBreathing", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
    };
    [_unit] call FUNC(handleAirway);
    [_unit] call FUNC(handlePuking);
}] call CBA_fnc_addEventHandler;

["deathTimerAirway", {_this call FUNC(handleTimer)}] call CBA_fnc_addEventHandler;
["ace_treatmentSucceded",{
    params ["", "_target", "", "_className"];
    if (toUpper _className isEqualTo "PERSONALAIDKIT" && local _target) exitWith {
        _target call FUNC(init);
        _target setVariable [QEGVAR(circulation,IV_counts), 0, true];
    };
 }] call CBA_fnc_addEventHandler;
