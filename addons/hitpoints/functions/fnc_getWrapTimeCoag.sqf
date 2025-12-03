#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Check for time to wrap a limb
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * Number
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_getWrapTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];

private _wounds = GET_COAGED_WOUNDS(_patient);
private _woundsOnPart = _wounds getOrDefault [_bodyPart, []];
private _filteredWounds = [];

{
    private _wound = _x;
    if (
        _wound isEqualType [] 
        && { ((_wound select 4) find "BloodClot") > -1 }
    ) then {
        _filteredWounds pushBack _wound;
    };
} forEach _woundsOnPart;

private _number = count _filteredWounds;
private _time = _number * GVAR(woundWrapTime);
TRACE_4("getWrap",_time,_number,_woundsOnPart,_filteredWounds);
_time