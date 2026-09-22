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

private _id = [GVAR(bloodSampleMap)] call FUNC(allocateSlot);

if (_id == -1) exitWith {
    [QGVAR(sampleDrawnLocal), [_medic, "full", -1], _medic] call CBA_fnc_targetEvent;
};

private _bloodGas = GET_BLOOD_GAS(_patient);

GVAR(bloodSampleMap) set [_id, [name _patient, _bloodGas, CBA_missionTime]];
missionNamespace setVariable [QGVAR(bloodSampleMap), GVAR(bloodSampleMap), true];

[QGVAR(sampleDrawnLocal), [_medic, "ok", _id], _medic] call CBA_fnc_targetEvent;
