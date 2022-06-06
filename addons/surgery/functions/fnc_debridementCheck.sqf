#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_fractureCheck;
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