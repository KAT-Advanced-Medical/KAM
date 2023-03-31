#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Checks Limb Damage before and IV can be used.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_pharma_fnc_checkIV;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if !(GVAR(ivCheckLimbDamage)) exitWith {
    true
};

private _bodyPartDamage = _patient getVariable [QACEGVAR(medical,bodyPartDamage), [0, 0, 0, 0, 0, 0]];
private _compare = ALL_BODY_PARTS find toLower _bodyPart;
private _final2 = 0;
private _return = false;

_final2 = _bodyPartDamage select _compare;

if (_final2 < 7) then {
    _return = true;
};

_return
