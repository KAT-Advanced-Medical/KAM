#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Starts the guided training for the player: spawns a healthy patient through the training computer and
 * walks the player through treating them step by step. Every step injures the patient and shows a hint
 * that stays until the injury is treated. Only one guided training runs per player.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call kat_training_fnc_startTutorial
 *
 * Public: No
 */

#define UPDATE_INTERVAL 1
// Gives the injuries of a step time to arrive before its condition is checked
#define STEP_SETTLE_TIME 3
// ACE lets a patient die once their time in cardiac arrest runs out, the training keeps it from getting this low
#define CARDIAC_ARREST_TIME_MIN 120

params [["_computer", objNull, [objNull]], ["_player", objNull, [objNull]]];

if (GVAR(tutorialHandle) != -1) exitWith {};

private _spawned = [_computer, _player, 0, 1] call FUNC(spawnPatient);

if (_spawned isEqualTo []) exitWith {};

// Patient, player, steps, step index, step start time
private _state = [_spawned select 0, _player, call FUNC(getTutorialSteps), -1, 0];

[_state, 0] call FUNC(enterTutorialStep);

GVAR(tutorialHandle) = [{
    params ["_state"];
    _state params ["_patient", "_player", "_steps", "_stepIndex", "_stepTime"];

    if (!alive _patient) exitWith {
        [false] call FUNC(stopTutorial);
        [LLSTRING(Tutorial_Failed_Title), LLSTRING(Tutorial_Failed_Text)] call FUNC(showTutorialHint);
    };

    // The patient stays unconscious for the whole training, medication or a restored pulse can still wake them up
    if !(IS_UNCONSCIOUS(_patient)) then {
        [QGVAR(addInjury), [_patient, "unconscious", [true]], _patient] call CBA_fnc_targetEvent;
    };

    // Leaves the player time to read the hints, a patient that bleeds out still dies
    if (local _patient && {IN_CRDC_ARRST(_patient)} && {(_patient getVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLeft), CARDIAC_ARREST_TIME_MIN]) < CARDIAC_ARREST_TIME_MIN}) then {
        _patient setVariable [QACEGVAR(medical_statemachine,cardiacArrestTimeLeft), CARDIAC_ARREST_TIME_MIN];
    };

    private _condition = (_steps select _stepIndex) select 2;

    if ((CBA_missionTime - _stepTime) < STEP_SETTLE_TIME || {!([_patient, _player] call _condition)}) exitWith {
        // Hints fade out on their own, showing the step again keeps it on screen
        [_state, _stepIndex, true] call FUNC(enterTutorialStep);
    };

    if ((_stepIndex + 1) >= count _steps) exitWith {
        [false] call FUNC(stopTutorial);
        [LLSTRING(Tutorial_Complete_Title), LLSTRING(Tutorial_Complete_Text)] call FUNC(showTutorialHint);
    };

    [_state, _stepIndex + 1] call FUNC(enterTutorialStep);
}, UPDATE_INTERVAL, _state] call CBA_fnc_addPerFrameHandler;
