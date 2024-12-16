#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_watch_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit"];

    if (GVAR(RangerActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Ranger" in assignedItems _unit) exitWith {
        _unit setVariable [QGVAR(rangerTimer), 0, false];
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _timeValue = _unit getVariable [QGVAR(rangerTimer), 0];
    private _active = _unit getVariable [QGVAR(rangerStart), false];
    
    if (_active) then {
        _timeValue = (_timeValue - 1) max 0;
        _unit setVariable [QGVAR(rangerTimer), _timeValue, false];

        if (_timeValue == 0) then {
            _unit setVariable [QGVAR(rangerStart), false, false];
            [QGVAR(playWatchTone), [_unit, QGVAR(watchAlarm)], _unit] call CBA_fnc_targetEvent;

            _pfhID call CBA_fnc_removePerFrameHandler;
        };
    };
}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;