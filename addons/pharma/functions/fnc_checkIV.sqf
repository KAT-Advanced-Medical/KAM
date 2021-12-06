#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
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
 * [player, cursorObject, "LeftLeg"] call kat_circulation_fnc_applyIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _bodyPartDamage = _patient getVariable ["ace_medical_bodyPartDamage", [0, 0, 0, 0, 0, 0]];
private _compare = ALL_BODY_PARTS find toLower _bodyPart;
private _final2 = 0;
private _return = false;

_final2 = _bodyPartDamage select _compare;

if (_final2 < 7) then {
    _return = true;
};

_return

