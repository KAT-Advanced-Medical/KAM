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
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_pharma_fnc_removeIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IV = _patient getVariable [QGVAR(IVsite), 0];
private _return = false;

if ((_IV isEqualTo _partIndex) && (_patient getVariable [QGVAR(IVplaced), false])) then {
    _return = true;
};

_return