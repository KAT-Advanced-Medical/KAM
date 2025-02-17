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

"KAT_STS" cutRsc ["KAT_STS", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_STS", displayNull])) exitWith {};

GVAR(STSActive) = true;

private _display = uiNamespace getVariable ["KAT_STS", displayNull];
private _background = _display displayCtrl 21800;
private _bigAlt = _display displayCtrl 21802;
private _smallAlt = _display displayCtrl 21803;
private _time = _display displayCtrl 21804;
private _hr = _display displayCtrl 21805;
private _o2 = _display displayCtrl 21806;
private _altitude = _display displayCtrl 21807;
private _descent = _display displayCtrl 21808;

private _altitudeUnit = GVAR(altitudeUnit);

// We seperate this into two PFHs because the compass PFH needs to be run much faster in order to rotate smoothly, but vitals only need an update every second because thats how fast handleUnitVitals runs.
[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_bigAlt", "_smallAlt", "_altitude", "_altitudeUnit"];

    if !(GVAR(STSActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _altitudeValue = round((getPosASL _unit) select 2);

    if (_altitudeUnit == 1) then {
        _altitudeValue = _altitudeValue * 3.281;
        _altitude ctrlSetText ([_altitudeValue, 1, 0] call CBA_fnc_formatNumber);
    } else {
        _altitude ctrlSetText ([_altitudeValue, 1, 0] call CBA_fnc_formatNumber);
    };

    _smallAlt ctrlSetAngle [(linearConversion [0, 100, (_altitudeValue % 100), 0, 360, true]), 0.5, 0.5, true];
    _smallAlt ctrlCommit 0.1;

    _bigAlt ctrlSetAngle [(linearConversion [0, 10000, _altitudeValue, 0, 360, true]), 0.5, 0.5, true];
    _bigAlt ctrlCommit 0.1;

}, 0.1, [
    _unit,
    _bigAlt,
    _smallAlt,
    _altitude,
    _altitudeUnit
]] call CBA_fnc_addPerFrameHandler;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_oldHeight", "_prevTime", "_time", "_hr", "_o2", "_descent", "_altitudeUnit"];

    if !(GVAR(STSActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideSWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_STS" in assignedItems _unit) exitWith {
        call FUNC(hideSWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _hour = floor dayTime;
    private _minute = floor ((dayTime - _hour) * 60);

    _time ctrlSetText (format ["%1:%2", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber]); 

    _hr ctrlSetText ([GET_HEART_RATE(_unit), 1, 0] call CBA_fnc_formatNumber);
    _o2 ctrlSetText ([GET_KAT_SPO2(_unit), 1, 0] call CBA_fnc_formatNumber);

    private _curTime = CBA_missionTime;
    private _timeDiff = _curTime - _prevTime;

    private _height = ((getPosASL _unit) select 2);
    private _descentRate = if (_timeDiff > 0) then {
        abs(floor((_height - _oldHeight) / _timeDiff))
    } else {
        0
    };

    if (_altitudeUnit == 1) then {
        _descentRate = _descentRate * 3.281;
        _descent ctrlSetText format[LLSTRING(descentFt), _descentRate];
    } else {
        _descent ctrlSetText format[LLSTRING(descentM), _descentRate];
    };

    (_this select 0) set [1, _height];
    (_this select 0) set [2, _curTime];
}, 0.5, [
    _unit,
    floor ((getPosASL _unit) select 2),
    CBA_missionTime,
    _time,
    _hr,
    _o2,
    _descent,
    _altitudeUnit
]] call CBA_fnc_addPerFrameHandler;
