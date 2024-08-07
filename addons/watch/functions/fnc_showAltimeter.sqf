#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Displays the altimeter on screen.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ACE_Parachute_fnc_showAltimeter
 *
 * Public: Yes
 */

params ["_unit"];

"KAT_Garmin" cutRsc ["KAT_Garmin", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_Garmin", displayNull])) exitWith {};

GVAR(GarminActive) = true;

private _display = uiNamespace getVariable ["KAT_Garmin", displayNull];
private _background = _display displayCtrl 19800;
private _compass = _display displayCtrl 19801;
private _rain = _display displayCtrl 19803;
private _overcast = _display displayCtrl 19804;
private _sun = _display displayCtrl 19805;
private _time = _display displayCtrl 22000;
private _month = _display displayCtrl 22001;
private _day = _display displayCtrl 22002;
private _baro = _display displayCtrl 22003;
private _hr = _display displayCtrl 22004;
private _o2 = _display displayCtrl 22005;
private _temp = _display displayCtrl 22006;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_compass", "_time", "_month", "_day", "_baro", "_hr", "_o2", "_temp", "_rain", "_overcast", "_sun"];

    if !(GVAR(GarminActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Garmin" in assignedItems _unit) exitWith {
        call FUNC(hideAltimeter);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    diag_log ((ctrlText _time));

    date params ["_yearNum", "_monthNum", "_dayNum"];

    private _hour = floor dayTime;
    private _minute = floor ((dayTime - _hour) * 60);

    _time ctrlSetText (format ["%1:%2", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber]);    
    _month ctrlSetText (["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"] select _monthNum);
    _day ctrlSetText (str(_dayNum));

    _compass ctrlSetAngle [(getDir _unit), 0.5, 0.5, true];
    _compass ctrlCommit 0.05;

    _baro ctrlSetText ([(((getTerrainHeightASL (getPosATL _unit)) call ACEFUNC(weather,calculateBarometricPressure)) / 1.3), 1, 0] call CBA_fnc_formatNumber);
    _hr ctrlSetText ([GET_HEART_RATE(_unit), 1, 0] call CBA_fnc_formatNumber);
    _o2 ctrlSetText ([(_unit getVariable [QEGVAR(breathing,airwayStatus), 100]), 1, 0] call CBA_fnc_formatNumber);
    _temp ctrlSetText (format ["%1C", ([((getTerrainHeightASL (getPosATL _unit)) call ACEFUNC(weather,calculateTemperatureAtHeight)), 1, 0] call CBA_fnc_formatNumber)]);

    switch (true) do {
        case(rain != 0): { _rain ctrlShow true; _overcast ctrlShow false; _sun ctrlShow false; };
        case(overcast > 25): { _rain ctrlShow false; _overcast ctrlShow true; _sun ctrlShow false; };
        default { _rain ctrlShow false; _overcast ctrlShow false; _sun ctrlShow true; };
    };

}, 0.05, [
    _unit,
    _compass,
    _time,
    _month,
    _day,
    _baro,
    _hr,
    _o2,
    _temp,
    _rain,
    _overcast,
    _sun
]] call CBA_fnc_addPerFrameHandler;
