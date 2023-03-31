#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Removes the IV from the patient on the given body part.
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Remove IV <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_pharma_fnc_removeIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _return = false;

if (_IVactual > 0) then {
    _return = true;
};

_return
