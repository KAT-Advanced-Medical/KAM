#include "script_component.hpp"
/*
 * Author: Mazinski.H, Katalam
 * Returns if the given player is having a iv on a given body part
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Has IV <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_pharma_fnc_hasIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

_IVactual > 0
