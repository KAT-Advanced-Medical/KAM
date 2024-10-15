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

"KAT_Cavmin" cutRsc ["KAT_Cavmin", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_Cavmin", displayNull])) exitWith {};

GVAR(CavminActive) = true;

private _display = uiNamespace getVariable ["KAT_Cavmin", displayNull];
private _background = _display displayCtrl 20800;
private _compass = _display displayCtrl 20802;
private _overlay = _display displayCtrl 20803;
private _time = _display displayCtrl 20804;
private _hr = _display displayCtrl 20805;
private _altitude = _display displayCtrl 20806;
private _bearing = _display displayCtrl 20807;


// We seperate this into two PFHs because the compass PFH needs to be run much faster in order to rotate smoothly, but vitals only need an update every second because thats how fast handleUnitVitals runs.
[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_compass", "_bearing"];

    if !(GVAR(CavminActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    _compass ctrlSetAngle [(linearConversion[0,360,(getDirVisual _unit),360,0]), 0.5, 0.5, true];
    _compass ctrlCommit 0.1;
    
    _bearing ctrlSetText (str(round(getDirVisual _unit)));
}, 0.05, [
    _unit,
    _compass,
    _bearing
]] call CBA_fnc_addPerFrameHandler;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_time", "_hr", "_altitude"];

    if !(GVAR(CavminActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideCWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Cavmin" in assignedItems _unit) exitWith {
        call FUNC(hideCWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    private _hour = floor dayTime;
    private _minute = floor ((dayTime - _hour) * 60);

    _time ctrlSetText (format ["%1:%2", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber]); 

    private _altitudeValue = (getPosASL _unit) select 2;

    if (GVAR(altitudeUnit) == 1) then {
        _altitude ctrlSetText ([(_altitudeValue * 3.281), 1, 0] call CBA_fnc_formatNumber);
    } else {
        _altitude ctrlSetText ([_altitudeValue, 1, 0] call CBA_fnc_formatNumber);
    };

    _hr ctrlSetText ([GET_HEART_RATE(_unit), 1, 0] call CBA_fnc_formatNumber);

}, 1, [
    _unit,
    _time,
    _hr,
    _altitude
]] call CBA_fnc_addPerFrameHandler;
