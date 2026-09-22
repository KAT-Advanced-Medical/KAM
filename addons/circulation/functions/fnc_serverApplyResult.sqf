#include "..\script_component.hpp"
/*
 * Author: Claude
 * Server handler for applying a blood gas result to a patient. Frees the result
 * slot and writes the tested blood gas onto the patient. Runs on the server only.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient the result is applied to <OBJECT>
 * 2: Result slot id <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, patient, 5] call kat_circulation_fnc_serverApplyResult;
 *
 * Public: No
 */

params ["_medic", "_patient", "_resultId"];

private _entry = GVAR(resultSampleMap) get _resultId;

if (isNil "_entry") exitWith {
    [QGVAR(resultAppliedLocal), [_medic, "invalid", -1], _medic] call CBA_fnc_targetEvent;
};

GVAR(resultSampleMap) deleteAt _resultId;
missionNamespace setVariable [QGVAR(resultSampleMap), GVAR(resultSampleMap), true];

_patient setVariable [QGVAR(testedBloodGas), (_entry get "bloodGas"), true];

[QGVAR(resultAppliedLocal), [_medic, "ok", _resultId], _medic] call CBA_fnc_targetEvent;
