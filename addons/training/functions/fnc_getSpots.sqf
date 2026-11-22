#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Returns the patient spots around a training computer, nearest first.
 * A spot is free when the patient spawned on it is dead, deleted or was moved away.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Only free spots <BOOL> (default: false)
 *
 * Return Value:
 * Patient spots <ARRAY>
 *
 * Example:
 * [cursorObject, true] call kat_training_fnc_getSpots
 *
 * Public: No
 */

// A spot stays taken while its patient lies this close to it
#define SPOT_OCCUPIED_RADIUS 1.5

params [["_computer", objNull, [objNull]], ["_freeOnly", false, [false]]];

private _spots = nearestObjects [_computer, [QGVAR(patientSpot)], PATIENT_SPOT_RADIUS];

if (!_freeOnly) exitWith {_spots};

_spots select {
    private _patient = _x getVariable [QGVAR(patient), objNull];

    !alive _patient || {(_patient distance _x) > SPOT_OCCUPIED_RADIUS}
}
