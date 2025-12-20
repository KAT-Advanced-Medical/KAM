#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Modified: Returns highest damage value instead of bool
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: BodyPartNumber <NUMBER>
 *
 * Return Value:
 * Highest damage amount <NUMBER>
 *
 * Public: No
 */

params ["_unit", "_bodyPartN"];

private _damage = GET_BODYPART_DAMAGE(_unit);
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
private _parts = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _highestDamage = 0;
{
    _highestDamage = _highestDamage max (_damage select _x);
} forEach _parts;
_highestDamage