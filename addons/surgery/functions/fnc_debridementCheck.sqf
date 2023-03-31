#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Checks if debridement can be performed
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Can Perform Debridement <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_debridementCheck;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _debridement = _patient getVariable [QGVAR(debridement), [0,0,0,0,0,0]];
private _compare = ALL_BODY_PARTS find toLower _bodyPart;
private _check = false;

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];

    if (_bodyPartN == _compare && (_amountOf > 0)) exitWith {
        _check = true;
    };

} forEach GET_STITCHED_WOUNDS(_patient);

if (_check) exitWith {true};

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];

    if (_bodyPartN == _compare && (_amountOf > 0)) exitWith {
        _check = true;
    };

} forEach GET_BANDAGED_WOUNDS(_patient);

if (_check) exitWith {true};

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];

    if (_bodyPartN == _compare && (_amountOf > 0)) exitWith {
        _check = true;
    };

} forEach GET_OPEN_WOUNDS(_patient);

if (_check) exitWith {true};

false
