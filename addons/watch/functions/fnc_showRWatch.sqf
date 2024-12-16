#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Modified: Mazinski
 * Displays the KWatch on screen.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_watch_fnc_showKWatch
 *
 * Public: Yes
 */

params ["_unit"];

"KAT_Ranger" cutRsc ["KAT_Ranger", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_Ranger", displayNull])) exitWith {};

GVAR(RangerActive) = true;

private _display = uiNamespace getVariable ["KAT_Ranger", displayNull];
private _background = _display displayCtrl 22800;
private _minute = _display displayCtrl 22802;
private _hour = _display displayCtrl 22803;
private _second = _display displayCtrl 22804;
private _time = _display displayCtrl 22806;
private _timer = _display displayCtrl 22807;
private _altitude = _display displayCtrl 22808;
private _hr = _display displayCtrl 22809;
private _o2 = _display displayCtrl 22810;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_hour", "_minute", "_second", "_time", "_timer", "_altitude", "_hr", "_o2"];

    if !(GVAR(RangerActive)) exitWith {
        [QGVAR(closeWatchTimer), [_unit], _unit] call CBA_fnc_targetEvent;
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideRWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Ranger" in assignedItems _unit) exitWith {
        call FUNC(hideRWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _altitudeValue = round((getPosASL _unit) select 2);

    if (GVAR(altitudeUnit) == 1) then {
        _altitude ctrlSetText ([(_altitudeValue * 3.281), 1, 0] call CBA_fnc_formatNumber);
    } else {
        _altitude ctrlSetText ([_altitudeValue, 1, 0] call CBA_fnc_formatNumber);
    };

    _hr ctrlSetText ([GET_HEART_RATE(_unit), 1, 0] call CBA_fnc_formatNumber);
    _o2 ctrlSetText ([GET_KAT_SPO2(_unit), 1, 0] call CBA_fnc_formatNumber);

    private _hours = floor dayTime;
    private _minutes = floor ((dayTime - _hours) * 60);
    private _seconds = floor ((((dayTime - _hours) * 60) - _minutes) * 60);

    _time ctrlSetText (format ["%1:%2:%3", [_hours, 2] call CBA_fnc_formatNumber, [_minutes, 2] call CBA_fnc_formatNumber, [_seconds, 2] call CBA_fnc_formatNumber]); 

    _hours = dayTime;

    if (_hours > 12) then {
        _hours = _hours - 12;
    };

    _hour ctrlSetAngle [(linearConversion [0, 12, _hours, 0, 360]), 0.5, 0.5, true];
    _minute ctrlSetAngle [(linearConversion [0, 60, _minutes, 0, 360]), 0.5, 0.5, true];
    _second ctrlSetAngle [(linearConversion [0, 60, _seconds, 0, 360]), 0.5, 0.5, true];

    private _timeValue = _unit getVariable [QGVAR(rangerTimer), 0];
    private _active = _unit getVariable [QGVAR(rangerStart), false];

    _timer ctrlSetText ([_timeValue, 2, 0] call CBA_fnc_formatNumber);
    
    if (_active) then {
        _timeValue = (_timeValue - 1) max 0;

        _timer ctrlSetText ([_timeValue, 2, 0] call CBA_fnc_formatNumber);
        _unit setVariable [QGVAR(rangerTimer), _timeValue, false];

        if (_timeValue == 0) then {
            _unit setVariable [QGVAR(rangerStart), false, false];
            [QGVAR(playWatchTone), [_unit, QGVAR(watchAlarm)], _unit] call CBA_fnc_targetEvent;
        };
    } else {
        _timer ctrlSetText ([_timeValue, 2, 0] call CBA_fnc_formatNumber);
    };
}, 1, [
    _unit,
    _hour,
    _minute,
    _second,
    _time,
    _timer,
    _altitude,
    _hr,
    _o2
]] call CBA_fnc_addPerFrameHandler;