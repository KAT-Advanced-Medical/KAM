#include "..\script_component.hpp"
/*
 * Author: Claude
 * Server handler for testing a blood sample at a vehicle. Moves the entry from
 * the sample pool to the result pool, freeing the sample slot, and replies to
 * the requesting medic so they can receive the result item and the sample item
 * can be removed from the vehicle. Runs on the server only.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Vehicle the sample was tested at <OBJECT>
 * 2: Sample slot id <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, vehicle, 3] call kat_circulation_fnc_serverTestSample;
 *
 * Public: No
 */

params ["_medic", "_vehicle", "_sampleId"];

if !(isServer) exitWith {};

private _entry = GVAR(bloodSampleMap) get _sampleId;

if (isNil "_entry") exitWith {
    [QGVAR(sampleTestedLocal), [_medic, "invalid", -1, _sampleId, _vehicle, []], _medic] call CBA_fnc_targetEvent;
};

private _resultId = [GVAR(resultSampleMap)] call FUNC(allocateSlot);

if (_resultId == -1) exitWith {
    [QGVAR(sampleTestedLocal), [_medic, "full", -1, _sampleId, _vehicle, []], _medic] call CBA_fnc_targetEvent;
};

GVAR(bloodSampleMap) deleteAt _sampleId;
missionNamespace setVariable [QGVAR(bloodSampleMap), GVAR(bloodSampleMap), true];

_entry set [2, CBA_missionTime];
GVAR(resultSampleMap) set [_resultId, _entry];
missionNamespace setVariable [QGVAR(resultSampleMap), GVAR(resultSampleMap), true];

[QGVAR(sampleTestedLocal), [_medic, "ok", _resultId, _sampleId, _vehicle, _entry], _medic] call CBA_fnc_targetEvent;
