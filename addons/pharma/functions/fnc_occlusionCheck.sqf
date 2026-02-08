#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Checks if an IV is occluded
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: BodyPartNumber
 *
 * Return Value:
 * IsOccluded (Bool)
 *
 * Example:
 * [player, 1] call kat_pharma_fnc_getBloodVolumeChange
 *
 * Public: No
 */

params ["_unit", "_bodypartN"];
private _tourniquets = GET_TOURNIQUETS(_unit);
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
private _idx = _occlusionMap findIf { _x#0 == _bodyPartN };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isOccluded = ({ _tourniquets select _x != 0 } count _result > 0);
_isOccluded