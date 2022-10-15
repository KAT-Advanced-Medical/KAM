#include "script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Soldier <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_overstretchHead;
 *
 * Public: No
 */

params ["_player", "_target"];

if (_target getVariable [QGVAR(overstretch), false]) exitWith {
    private _output = localize LSTRING(Airway_already);
    [_output, 2, _player] call ace_common_fnc_displayTextStructured;
    false;
};
if !(_target getVariable [QGVAR(obstruction), false]) exitWith {
    private _output = localize LSTRING(Airway_NA);
    [_output, 2, _player] call ace_common_fnc_displayTextStructured;
    false;
};

_target setVariable [QGVAR(overstretch), true, true];

private _output = localize LSTRING(overstretch_info);
[_output, 2, _player] call ace_common_fnc_displayTextStructured;

[{
    params ["_player", "_target"];
    (_target distance2D _player) > 5;
}, {
    params ["_player", "_target"];
    if (_target getVariable [QGVAR(recovery), false]) exitWith {};
    _target setVariable [QGVAR(overstretch), false, true];
    _output = localize LSTRING(overstretch_cancel);
    [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
}, [_player, _target], 600, {
    params ["_player", "_target"];
    if (_target getVariable [QGVAR(recovery), false]) exitWith {};
    _target setVariable [QGVAR(overstretch), false, true];
    _output = localize LSTRING(overstretch_cancel);
    [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
}] call CBA_fnc_waitUntilAndExecute;

true;
