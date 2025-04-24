#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks if medication will be occluded by a TQ
 *
 * Arguments:
 * 0: Target <object>
 * 1: Part Index
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, 4] call kat_pharma_fnc_occlusionCheck
 *
 * Public: No
 */
 
params ["_patient", "_partIndex"];

private _occlusionMap = [
    [HITPOINT_INDEX_LARM, [HITPOINT_INDEX_LARM, HITPOINT_INDEX_ULARM]],
    [HITPOINT_INDEX_ULARM, [HITPOINT_INDEX_ULARM]],
    [HITPOINT_INDEX_RARM, [HITPOINT_INDEX_RARM, HITPOINT_INDEX_URARM]],
    [HITPOINT_INDEX_URARM, [HITPOINT_INDEX_URARM]],
    [HITPOINT_INDEX_LLEG, [HITPOINT_INDEX_LLEG, HITPOINT_INDEX_ULLEG]],
    [HITPOINT_INDEX_ULLEG, [HITPOINT_INDEX_ULLEG]],
    [HITPOINT_INDEX_RLEG, [HITPOINT_INDEX_RLEG, HITPOINT_INDEX_URLEG]],
    [HITPOINT_INDEX_URLEG, [HITPOINT_INDEX_URLEG]]
];

private _tourniquets = GET_TOURNIQUETS(_patient);
private _occludingSites = (_occlusionMap select {_x#0 == _partIndex}) param [0, [], [[],[]]] param [1, []];
_occludingSites findIf { (_tourniquets select _x) > 0 } != -1