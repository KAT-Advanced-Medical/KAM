#include "..\script_component.hpp"
/*
 * Author: Claude
 * Server handler for a blood sample draw request. Allocates a free sample slot,
 * stores the entry authoritatively and replies to the requesting medic so they
 * can receive the physical item. Runs on the server only.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, patient] call kat_circulation_fnc_serverDrawSample;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(isServer) exitWith {};

if (isNull _patient) exitWith {
    [QGVAR(sampleDrawnLocal), [_medic, "invalid", -1], _medic] call CBA_fnc_targetEvent;
};

private _id = [GVAR(bloodSampleMap)] call FUNC(allocateSlot);

if (_id == -1) exitWith {
    [QGVAR(sampleDrawnLocal), [_medic, "full", -1], _medic] call CBA_fnc_targetEvent;
};

private _bloodGas = GET_BLOOD_GAS(_patient);

// 4th element is the current holder of the physical item this slot represents,
// kept up to date on every hand-off so fnc_serverSweepExpiredSamples can strip a
// stale item instead of leaving it to collide with a future slot reuse
GVAR(bloodSampleMap) set [_id, [name _patient, _bloodGas, CBA_missionTime, _medic]];
missionNamespace setVariable [QGVAR(bloodSampleMap), GVAR(bloodSampleMap), true];

[QGVAR(sampleDrawnLocal), [_medic, "ok", _id], _medic] call CBA_fnc_targetEvent;
