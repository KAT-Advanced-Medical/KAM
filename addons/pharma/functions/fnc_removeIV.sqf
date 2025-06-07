#include "..\script_component.hpp"
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
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _return = false;

private _limbIndices = [
    ["leftarm", [4, 5]],
    ["rightarm", [6, 7]],
    ["leftleg", [8, 9]],
    ["rightleg", [10, 11]],
    ["upperleftarm", [4, 5]],
    ["upperrightarm", [6, 7]],
    ["upperleftleg", [8, 9]],
    ["upperrightleg", [10, 11]]
];

private _limb = _limbIndices select {_x#0 == toLower _bodyPart};

if (count _limb > 0) then {
    {
        if ((_IVarray select _x) > 0) exitWith {_return = true};
    } forEach (_limb#0#1);
} else {
    if (_partIndex >= 0 && (_IVarray select _partIndex) > 0) then {
        _return = true;
    };
};

_return
