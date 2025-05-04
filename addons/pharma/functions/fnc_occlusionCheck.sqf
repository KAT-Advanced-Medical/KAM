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
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];

private _tourniquets = GET_TOURNIQUETS(_patient);
private _idx = _occlusionMap findIf { _x#0 == _partIndex };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isNotOccluded = { _tourniquets select _x != 0 } count _result > 0;