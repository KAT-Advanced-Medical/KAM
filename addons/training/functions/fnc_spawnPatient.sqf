#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Spawns training patients for a training computer and wounds them according to the chosen severity.
 * Each patient is spawned on a free patient spot (kat_training_patientSpot) near the computer, nearest first,
 * so the amount of free spots limits how many can be spawned. The last one spawned becomes the selected patient.
 *
 * Without any patient spot near the computer, a single patient is spawned behind the player instead.
 *
 * Mission makers can set kat_training_patientClass on the computer to change the unit class.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Player <OBJECT>
 * 2: Severity, 0 (healthy) to 4 (critical) <NUMBER> (default: 0)
 * 3: Amount of patients <NUMBER> (default: 1)
 *
 * Return Value:
 * Spawned patients <ARRAY>
 *
 * Example:
 * [cursorObject, player, 3, 2] call kat_training_fnc_spawnPatient
 *
 * Public: No
 */

#define PATIENT_CLASS "B_Soldier_F"
#define PATIENT_SPAWN_DISTANCE 2
// Lets the unit finish its medical initialisation before it is wounded
#define INJURY_DELAY 1
#define NO_SELF_TREATMENT_TIME 1e9

params [["_computer", objNull, [objNull]], ["_player", objNull, [objNull]], ["_severity", 0, [0]], ["_amount", 1, [0]]];

if (isNull _computer || {isNull _player}) exitWith {[]};

// Position ASL, direction and patient spot of every patient to spawn
private _placements = [];

if (([_computer] call FUNC(getSpots)) isEqualTo []) then {
    _placements pushBack [AGLToASL (_player modelToWorld [0, -PATIENT_SPAWN_DISTANCE, 0]), getDir _player, objNull];
} else {
    private _freeSpots = [_computer, true] call FUNC(getSpots);

    _placements = (_freeSpots select [0, round _amount max 1]) apply {[getPosASL _x, getDir _x, _x]};
};

if (_placements isEqualTo []) exitWith {
    [LLSTRING(NoFreeSpot), 1.5, _player] call ACEFUNC(common,displayTextStructured);
    []
};

private _class = _computer getVariable [QGVAR(patientClass), PATIENT_CLASS];
private _group = createGroup [civilian, true];
private _spawned = [];

{
    _x params ["_positionASL", "_direction", "_spot"];

    private _patient = _group createUnit [_class, ASLToAGL _positionASL, [], 0, "CAN_COLLIDE"];

    // createUnit keeps the config side of the class, joining again makes the patient a civilian
    [_patient] joinSilent _group;

    _patient setPosASL _positionASL;
    _patient setDir _direction;
    _patient disableAI "MOVE";
    _patient disableAI "FSM";
    _patient disableAI "TARGET";
    _patient disableAI "AUTOTARGET";

    // ACE medical AI only treats itself and others once it has not fired for a while, which never comes
    _patient setVariable [QACEGVAR(medical_ai,lastFired), NO_SELF_TREATMENT_TIME, true];

    if (!isNull _spot) then {
        _spot setVariable [QGVAR(patient), _patient, true];
    };

    _spawned pushBack _patient;
} forEach _placements;

private _patients = [_computer] call FUNC(getPatients);
_patients append _spawned;

_computer setVariable [QGVAR(patients), _patients, true];
_computer setVariable [QGVAR(patient), _spawned select -1, true];
missionNamespace setVariable [QGVAR(spawned), true, true];

if (_severity > 0) then {
    [{
        params ["_spawned", "_severity"];

        {
            [QGVAR(addInjury), [_x, "severity", [_severity]], _x] call CBA_fnc_targetEvent;
        } forEach _spawned;
    }, [_spawned, _severity], INJURY_DELAY] call CBA_fnc_waitAndExecute;
};

[LLSTRING(PatientSpawned), 1.5, _player] call ACEFUNC(common,displayTextStructured);

_spawned
