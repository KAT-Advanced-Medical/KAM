#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates list control with given logs.
 *
 * Arguments:
 * 0: Log list <CONTROL>
 * 1: Log to add <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlActivityLog, _activityLog] call ace_medical_gui_fnc_updateLogList
 *
 * Public: No
 */

params ["_ctrl", "_logs"];

lbClear _ctrl;

{
    _x params ["_message", "_timeStamp", "_arguments"];

    //set us the original string into a var to check the afterwards
    _messageWOlocalization = _message;

    // Localize message and arguments
    if (isLocalized _message) then {
        _message = localize _message;
    };

    _arguments = _arguments apply {if (_x isEqualType "" && {isLocalized _x}) then {localize _x} else {_x}};

    // Format message with arguments
    _message = format ([_message] + _arguments);

    _rowIdc = _ctrl lbAdd format ["%1 %2", _timeStamp, _message];

    //Color the logs if enabled by Airway Settings of KAM
    if (GVAR(ColoredLogs)) then {
        if (_messageWOlocalization isEqualTo ELSTRING(breathing,pulseoxi_Log)) then {
            if (((_arguments select 0) < 45 )
            || ((_arguments select 0) > 120 )
            || ((_arguments select 1) < 75 )) then {
                _ctrl lbSetColor [_rowIdc, [1, 0, 0, 1]];
            };
        };
        if (_messageWOlocalization isEqualTo ELSTRING(circulation,VitalsMonitor_StatusLog)) then {
            if (((_arguments select 0) < 45 )
            || ((_arguments select 0) > 120 )
            || ((_arguments select 1) < 50 )
            || ((_arguments select 1) > 200 )
            || ((_arguments select 2) < 60 )
            || ((_arguments select 2) > 145 )
            || ((_arguments select 3) < 75 )) then {
                _ctrl lbSetColor [_rowIdc, [1, 0, 0, 1]];
            };
        };
        if (_messageWOlocalization isEqualTo ELSTRING(circulation,VitalsMonitor_VMInactive_StatusLog)) then {
            if (((_arguments select 0) < 45 )
            || ((_arguments select 0) > 120 )) then {
                _ctrl lbSetColor [_rowIdc, [1, 0, 0, 1]];
            };
        };
        if (_messageWOlocalization isEqualTo ELSTRING(circulation,VitalsMonitor_VMActive_StatusLog)) then {
            if (((_arguments select 0) < 45 )
            || ((_arguments select 0) > 120 )
            || ((_arguments select 1) < 50 )
            || ((_arguments select 1) > 200 )
            || ((_arguments select 2) < 60 )
            || ((_arguments select 2) > 145 )
            || ((_arguments select 3) < 75 )) then {
                _ctrl lbSetColor [_rowIdc, [1, 0, 0, 1]];
            };
        };
    };
    
} forEach _logs;
