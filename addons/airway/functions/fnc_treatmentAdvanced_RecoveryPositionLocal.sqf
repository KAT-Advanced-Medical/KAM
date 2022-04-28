#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for set patient into recovery position.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Successful treatment
 *
 * Example:
 * call kat_breathing_fnc_RecoveryPositionLocal
 *
 * Public: No
 */

params ["_player", "_target"];

if (_target getVariable [QGVAR(recovery), false]) exitWith {
    private _output = localize LSTRING(Recovery_Already);
    [_output, 2, _player] call ace_common_fnc_displayTextStructured;
    false;
};

_target setVariable [GVAR(recovery), true, true];

private _output = localize LSTRING(Recovery_Info);
[_output, 2, _player] call ace_common_fnc_displayTextStructured;

[{
    params ["_player", "_target"];
    (_target call ace_medical_status_fnc_isBeingDragged) || (_target call ace_medical_status_fnc_isBeingCarried) || !(isNull objectParent _target);
}, {
    params ["_player", "_target"];
    _target setVariable [QGVAR(recovery), false, true];
    _output = localize LSTRING(Recovery_Cancel);
    [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
}] call CBA_fnc_waitUntilAndExecute;

true;