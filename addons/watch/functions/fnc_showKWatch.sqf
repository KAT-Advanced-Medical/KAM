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

"KAT_Katmin" cutRsc ["KAT_Katmin", "PLAIN", 0, true];

if (isNull (uiNamespace getVariable ["KAT_Katmin", displayNull])) exitWith {};

GVAR(KatminActive) = true;

private _display = uiNamespace getVariable ["KAT_Katmin", displayNull];
private _background = _display displayCtrl 19800;
private _compass = _display displayCtrl 19806;
private _sun = _display displayCtrl 19803;
private _overcast = _display displayCtrl 19804;
private _rain = _display displayCtrl 19805;
private _time = _display displayCtrl 22000;
private _month = _display displayCtrl 22001;
private _day = _display displayCtrl 22002;
private _baro = _display displayCtrl 22003;
private _hr = _display displayCtrl 22004;
private _o2 = _display displayCtrl 22005;
private _temp = _display displayCtrl 22006;
private _altitude = _display displayCtrl 22007;

// We seperate this into two PFHs because the compass PFH needs to be run much faster in order to rotate smoothly, but vitals only need an update every second because thats how fast handleUnitVitals runs.
[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_compass"];

    if !(GVAR(KatminActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    _compass ctrlSetAngle [(linearConversion[0,360,(getDirVisual _unit),360,0]), 0.5, 0.5, true];
    _compass ctrlCommit 0.1;
}, 0.05, [
    _unit,
    _compass
]] call CBA_fnc_addPerFrameHandler;

[{
    _this params ["_args", "_pfhID"];
    _args params ["_unit", "_time", "_month", "_day", "_baro", "_hr", "_o2", "_temp", "_altitude", "_rain", "_overcast", "_sun"];

    if !(GVAR(KatminActive)) exitWith {
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !(alive _unit) exitWith {
        call FUNC(hideKWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    if !("KAT_Katmin" in assignedItems _unit) exitWith {
        call FUNC(hideKWatch);
        _pfhID call CBA_fnc_removePerFrameHandler;
    };

    date params ["_yearNum", "_monthNum", "_dayNum"];

    private _hour = floor dayTime;
    private _minute = floor ((dayTime - _hour) * 60);

    _time ctrlSetText (format ["%1:%2", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber]);    
    _month ctrlSetText (["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"] select (_monthNum - 1));
    _day ctrlSetText (str(_dayNum));

    private _altitudeValue = (getPosASL _unit) select 2;

    if (GVAR(altitudeUnit) == 1) then {
        _altitude ctrlSetText ([(_altitudeValue * 3.281), 1, 0] call CBA_fnc_formatNumber);
    } else {
        _altitude ctrlSetText ([_altitudeValue, 1, 0] call CBA_fnc_formatNumber);
    };

    if (GVAR(pressureUnit) == 1) then {
        _baro ctrlSetText ([(_altitudeValue call ACEFUNC(weather,calculateBarometricPressure)), 1, 0] call CBA_fnc_formatNumber);
    } else {
        _baro ctrlSetText ([((_altitudeValue call ACEFUNC(weather,calculateBarometricPressure)) / 1.3), 1, 0] call CBA_fnc_formatNumber);
    };

    if (GVAR(temperatureUnit) == 1) then {
        _temp ctrlSetText (format ["%1F", ([((_altitudeValue call ACEFUNC(weather,calculateTemperatureAtHeight)) * (9/5) + 32), 1, 0] call CBA_fnc_formatNumber)]);
    } else {
        _temp ctrlSetText (format ["%1C", ([(_altitudeValue call ACEFUNC(weather,calculateTemperatureAtHeight)), 1, 0] call CBA_fnc_formatNumber)]);
    };

    _hr ctrlSetText ([GET_HEART_RATE(_unit), 1, 0] call CBA_fnc_formatNumber);
    _o2 ctrlSetText ([GET_KAT_SPO2(_unit), 1, 0] call CBA_fnc_formatNumber);

    switch (true) do {
        case(rain != 0): { _rain ctrlShow true; _overcast ctrlShow false; _sun ctrlShow false; };
        case(overcast > 0.4): { _rain ctrlShow false; _overcast ctrlShow true; _sun ctrlShow false; };
        default { _rain ctrlShow false; _overcast ctrlShow false; _sun ctrlShow true; };
    };

}, 1, [
    _unit,
    _time,
    _month,
    _day,
    _baro,
    _hr,
    _o2,
    _temp,
    _altitude,
    _rain,
    _overcast,
    _sun
]] call CBA_fnc_addPerFrameHandler;
