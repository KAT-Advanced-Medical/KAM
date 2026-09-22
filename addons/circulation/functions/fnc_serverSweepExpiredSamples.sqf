#include "..\script_component.hpp"
/*
 * Author: Claude
 * Periodic server-side cleanup: frees blood sample and result slots that were
 * never tested or applied within SAMPLE_EXPIRY_TIME (item lost, dropped,
 * medic disconnected, vehicle destroyed). Also strips the stale physical item
 * from its last known holder - otherwise a reused slot id could silently
 * resolve a leftover item against a different, newer entry. Runs on the
 * server only.
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
    params ["_map", "_itemClassFormat"];

    // Collect first, delete after: mutating a HashMap while a forEach is iterating it is unverified
    private _expired = [];
    { if ((_now - (_y select 2)) > _expiry) then { _expired pushBack [_x, _y select 3]; }; } forEach _map;

    {
        _x params ["_id", "_holder"];
        _map deleteAt _id;

        if (!isNull _holder) then {
            [QGVAR(itemExpired), [_holder, format [_itemClassFormat, _id]], _holder] call CBA_fnc_targetEvent;
        };
    } forEach _expired;

    _expired isNotEqualTo []
};

if ([GVAR(bloodSampleMap), "KAT_bloodSample_%1"] call _fnc_sweep) then {
    missionNamespace setVariable [QGVAR(bloodSampleMap), GVAR(bloodSampleMap), true];
};

if ([GVAR(resultSampleMap), "KAT_bloodResult_%1"] call _fnc_sweep) then {
    missionNamespace setVariable [QGVAR(resultSampleMap), GVAR(resultSampleMap), true];
};
