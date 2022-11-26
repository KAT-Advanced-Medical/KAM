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
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_RecoveryPositionLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(recovery), true, true];
_patient setVariable [QGVAR(overstretch), true, true];
_patient setVariable [QGVAR(occluded), false, true];

private _output = LLSTRING(Recovery_Info);
[_output, 2, _medic] call ACEFUNC(common,displayTextStructured);

[{
    params ["_medic", "_patient"];
    (_patient call ACEFUNC(medical_status,isBeingDragged)) || (_patient call ACEFUNC(medical_status,isBeingCarried)) || !(isNull objectParent _patient);
}, {
    params ["_medic", "_patient"];
    _patient setVariable [QGVAR(recovery), false, true];
    _patient setVariable [QGVAR(overstretch), false, true];

    _output = LLSTRING(Recovery_Cancel);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}, [_medic, _patient], 3600, {
    params ["_medic","patient"];
    _patient setVariable [QGVAR(recovery), false, true];
    _patient setVariable [QGVAR(overstretch), false, true];
    
    _output = LLSTRING(Recovery_Cancel);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;
