#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Starts a step of the guided training: gives the patient the injuries of the step, shows its hint
 * and shows or hides the heart rhythm chart.
 *
 * Arguments:
 * 0: Guided training state, [patient, player, steps, step index, step start time] <ARRAY>
 * 1: Index of the step to start <NUMBER>
 * 2: Show without the hint sound <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_state, 1] call kat_training_fnc_enterTutorialStep
 *
 * Public: No
 */

params ["_state", "_stepIndex", ["_silent", false, [false]]];
_state params ["_patient", "", "_steps", "_currentIndex"];

(_steps select _stepIndex) params ["_key", "_injuries", "", ["_showChart", false, [false]]];

// The hint is refreshed with the index it already has, only a new step injures the patient
if (_stepIndex != _currentIndex) then {
    _state set [3, _stepIndex];
    _state set [4, CBA_missionTime];

    {
        _x params ["_type", "_args"];

        [QGVAR(addInjury), [_patient, _type, _args], _patient] call CBA_fnc_targetEvent;
    } forEach _injuries;

    if (_showChart) then {
        QGVAR(rhythmChart) cutRsc [QGVAR(rhythmChart), "PLAIN", 0, false];
    } else {
        QGVAR(rhythmChart) cutText ["", "PLAIN", 0];
    };
};

[
    localize format ["%1_%2_Title", LSTRING(Tutorial), _key],
    localize format ["%1_%2_Text", LSTRING(Tutorial), _key],
    format [LLSTRING(Tutorial_Progress), _stepIndex + 1, count _steps],
    _silent
] call FUNC(showTutorialHint);
