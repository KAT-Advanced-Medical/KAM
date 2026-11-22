#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Deletes the selected patient of a training computer, or all of its patients.
 * After deleting the selected patient, the next living one becomes selected.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Player <OBJECT>
 * 2: Delete all patients <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player, true] call kat_training_fnc_deletePatient
 *
 * Public: No
 */

params [["_computer", objNull, [objNull]], ["_player", objNull, [objNull]], ["_all", false, [false]]];

private _patients = [_computer] call FUNC(getPatients);
private _toDelete = [[_computer getVariable [QGVAR(patient), objNull]], _patients] select _all;

_patients = _patients - _toDelete;

{
    deleteVehicle _x;
} forEach (_toDelete select {!isNull _x});

private _livingIndex = _patients findIf {alive _x};

_computer setVariable [QGVAR(patients), _patients, true];
_computer setVariable [QGVAR(patient), _patients param [_livingIndex max 0, objNull], true];
missionNamespace setVariable [QGVAR(spawned), _patients isNotEqualTo [], true];

[LLSTRING(PatientDeleted), 1.5, _player] call ACEFUNC(common,displayTextStructured);
