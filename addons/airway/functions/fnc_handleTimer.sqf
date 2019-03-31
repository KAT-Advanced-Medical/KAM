#include "script_component.hpp"
/*
 * Author: Katalam
 * Death time handler for airway damage
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, CBA_missionTime] call kat_airway_fnc_handleTimer;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "_time"];

if !(GVAR(enable)) exitWith {};

if (!local _unit) exitWith {
    ["deathTimerAirway", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};
if (EGVAR(breathing,enable)) then {
    ["handleBreathing", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};
if (EGVAR(breathing,death_timer_enable)) exitWith {};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_startTime"];
    private _startTimeVariable = _unit getVariable [QGVAR(startTime), CBA_missionTime];
    if (_startTimeVariable != 0 && _startTimeVariable > _startTime) then {
        _startTime = _startTimeVariable;
    };
    if ([_unit] call ace_common_fnc_isAwake || _unit getVariable [QGVAR(airway), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(startTime), 0, false];
    };
    if (_unit getVariable [QGVAR(overstretch), false]) exitWith {
        _unit setVariable [QGVAR(startTime), (_startTime + 2), false];
    };
    if (CBA_missionTime - _startTime >= GVAR(deathTimer) &&
        (_unit getVariable [QGVAR(obstruction), false] || _unit getVariable ["ace_medical_airwayOccluded", false])) then {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(startTime), 0, false];
        [_unit, true] call ace_medical_fnc_setDead;
    };
}, 1, [_unit, _time]] call CBA_fnc_addPerFrameHandler;
