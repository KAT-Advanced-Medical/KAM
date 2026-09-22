#include "..\script_component.hpp"
/*
 * Author: Claude
 * Periodic server-side cleanup: frees blood sample and result slots that were
 * never tested or applied within SAMPLE_EXPIRY_TIME (item lost, dropped,
 * medic disconnected, vehicle destroyed). Runs on the server only.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_circulation_fnc_serverSweepExpiredSamples;
 *
 * Public: No
 */

if !(isServer) exitWith {};

private _expiry = SAMPLE_EXPIRY_TIME * 60;
private _now = CBA_missionTime;

private _fnc_sweep = {
    params ["_map"];

    // Collect first, delete after: mutating a HashMap while a forEach is iterating it is unverified
    private _expired = [];
    { if ((_now - (_y select 2)) > _expiry) then { _expired pushBack _x; }; } forEach _map;
    { _map deleteAt _x; } forEach _expired;

    _expired isNotEqualTo []
};

if ([GVAR(bloodSampleMap)] call _fnc_sweep) then {
    missionNamespace setVariable [QGVAR(bloodSampleMap), GVAR(bloodSampleMap), true];
};

if ([GVAR(resultSampleMap)] call _fnc_sweep) then {
    missionNamespace setVariable [QGVAR(resultSampleMap), GVAR(resultSampleMap), true];
};
