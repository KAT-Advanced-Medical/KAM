#include "script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Removes the tourniquet from the patient on the given body part.
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
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_tourniquetRemove
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IV = _patient getVariable [QGVAR(IVsite), 0];
private _return = false;

if ((_IV == _partIndex) && (_patient getVariable [QGVAR(IVplaced), false])) then {
    _return = true;
};

_return