#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can wrap Wounds on a limb
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>

 * Return Value:
 * Bool
 *
 * Example:
 * [player, cursorTarget, "Head", "FieldDressing"] call kat_hitpoints_fnc_canWrapWound
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_bandage"];
_bodyPart = toLowerANSI _bodyPart;

// If patient is swimming, don't allow bandage actions.
if (_patient call ACEFUNC(common,isSwimming)) exitWith {false};

private _canWrap = true;

{
    _x params ["", "_amountOf", "_bleeding"];
    if (_amountOf * _bleeding > 0) exitWith {
        _canWrap = false;
    };
    
} forEach ((GET_OPEN_WOUNDS(_patient)) getOrDefault [_bodyPart, []]);
_canWrap