#include "..\script_component.hpp"
/*
 * Author: Blue, Brett Mayson
 * Handles the coloring of rows added to the log list
 *
 * Arguments:
 * 0: List control <CONTROL>
 * 1: Row IDC <NUMBER>
 * 2: Localized Message <STRING>
 * 3: Unlocalized Message <STRING>
 * 4: Time Stamp <STRING>
 * 5: Arguments <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrl, _row, _message, _unlocalizedMessage, _timeStamp, _arguments] call kat_gui_fnc_logListAppended
 *
 * Public: No
 */

if (!GVAR(ColoredLogs)) exitWith {};

params ["_ctrl", "_row", "_message", "_unlocalizedMessage", "_timeStamp", "_arguments"];

if (_unlocalizedMessage isEqualTo ELSTRING(breathing,pulseoxi_Log)) exitWith {
    if (((_arguments select 0) < 45 )
    || ((_arguments select 0) > 120 )
    || ((_arguments select 1) < 75 )) then {
        _ctrl lbSetColor [_row, [1, 0, 0, 1]];
    };
};
if (_unlocalizedMessage isEqualTo ELSTRING(circulation,VitalsMonitor_StatusLog)) exitWith {
    if (((_arguments select 0) < 45 )
    || ((_arguments select 0) > 120 )
    || ((_arguments select 1) < 50 )
    || ((_arguments select 1) > 200 )
    || ((_arguments select 2) < 60 )
    || ((_arguments select 2) > 145 )
    || ((_arguments select 3) < 75 )) then {
        _ctrl lbSetColor [_row, [1, 0, 0, 1]];
    };
};
if (_unlocalizedMessage isEqualTo ELSTRING(circulation,VitalsMonitor_VMInactive_StatusLog)) exitWith {
    if (((_arguments select 0) < 45 )
    || ((_arguments select 0) > 120 )) then {
        _ctrl lbSetColor [_row, [1, 0, 0, 1]];
    };
};
if (_unlocalizedMessage isEqualTo ELSTRING(circulation,VitalsMonitor_VMActive_StatusLog)) exitWith {
    if (((_arguments select 0) < 45 )
    || ((_arguments select 0) > 120 )
    || ((_arguments select 1) < 50 )
    || ((_arguments select 1) > 200 )
    || ((_arguments select 2) < 60 )
    || ((_arguments select 2) > 145 )
    || ((_arguments select 3) < 75 )) then {
        _ctrl lbSetColor [_row, [1, 0, 0, 1]];
    };
};
