#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Removes blood gas testing values
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_dumpBloodGas;
 *
 * Public: No
 */

params ["_target"];
private _lastTime = _unit getVariable [QEGVAR(circulation,bloodGasTime), 0, true];
private _now = CBA_missionTime;
private _hours = floor (_elapsed / 3600);
private _minutes = floor ((_elapsed % 3600) / 60);
private _seconds = floor (_elapsed % 60);
private _time = format [
        "%1:%2:%3",
        [_hours, 2] call CBA_fnc_formatNumber,
        [_minutes, 2] call CBA_fnc_formatNumber,
        [_seconds, 2] call CBA_fnc_formatNumber
    ];
if (_lastTime <= 0) exitWith {
   _time =  "00:00:00";
};
_time

