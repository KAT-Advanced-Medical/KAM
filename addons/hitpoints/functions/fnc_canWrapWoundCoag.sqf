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

params ["_medic", "_patient", "_bodyPart"];
_bodyPart = toLowerANSI _bodyPart;

private _bandagedWounds = GET_COAGED_WOUNDS(_patient);

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
if (_bandagedWoundsOnPart isEqualTo []) exitWith { false };

private _hasBloodClotBandage = _bandagedWoundsOnPart findIf {
    (_x param [4, ""]) find "BloodClot" > -1
} != -1;

TRACE_2("canwrap",_hasBloodClotBandage,_bandagedWoundsOnPart);
_hasBloodClotBandage