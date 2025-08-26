#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can wrap a splint on a limb
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_canWrapSplint
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];
if (_patient call ACEFUNC(common,isSwimming)) exitWith {false};
if (ACEGVAR(medical,fractures) in [0, 1]) exitWith {false};
private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;

(GET_FRACTURES(_patient) select _partIndex) == -1
