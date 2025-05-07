#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Callback to wrap a splint on a bodypart
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>

 * Return Value:
 * None
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_wrapSplint
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;

private _fractures = GET_FRACTURES(_patient);
_fractures set [_partIndex, -2];
_patient setVariable [VAR_FRACTURES, _fractures, true];
