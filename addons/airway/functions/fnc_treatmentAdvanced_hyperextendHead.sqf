#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_hyperextendHead;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (_patient getVariable [QGVAR(overstretch), false]) exitWith {
    private _output = LLSTRING(Hyperextend_already);
    [_output, 2, _medic] call ACEFUNC(common,displayTextStructured);
};
if !(_patient getVariable [QGVAR(obstruction), false]) exitWith {
    private _output = LLSTRING(AirwayStatus_Clear);
    [_output, 2, _medic] call ACEFUNC(common,displayTextStructured);
};

_patient setVariable [QGVAR(overstretch), true, true];

private _output = LLSTRING(Hyperextend_Warning);
[_output, 2, _medic] call ACEFUNC(common,displayTextStructured);

[{
    params ["_medic", "_patient"];
    (_patient distance2D _medic) > 5;
}, {
    params ["_medic", "_patient"];
    if (_patient getVariable [QGVAR(recovery), false]) exitWith {};
    _patient setVariable [QGVAR(overstretch), false, true];
    _output = LLSTRING(Hyperextend_Cancel);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}, [_medic, _patient], 3600, {
    params ["_medic", "_patient"];
    if (_patient getVariable [QGVAR(recovery), false]) exitWith {};
    _patient setVariable [QGVAR(overstretch), false, true];
    _output = LLSTRING(Hyperextend_Cancel);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;
