#include "..\script_component.hpp"
/*
 * Author: Claude
 * Finds a free numeric slot in the given map, used to assign a blood sample or
 * blood result its physical item id (KAT_bloodSample_N / KAT_bloodResult_N, N = 1..MAX_SAMPLE_SLOTS).
 *
 * Arguments:
 * 0: Map to search <HASHMAP>
 *
 * Return Value:
 * Free slot id, or -1 if every slot is occupied <NUMBER>
 *
 * Example:
 * [GVAR(bloodSampleMap)] call kat_circulation_fnc_allocateSlot;
 *
 * Public: No
 */

params ["_map"];

private _id = -1;
private _used = keys _map;

for "_i" from 1 to MAX_SAMPLE_SLOTS do {
    if !(_i in _used) exitWith {
        _id = _i;
    };
};

_id
