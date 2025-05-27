#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can wrap a splint on a limb
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_canWrapSplint
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];
if (_patient call ACEFUNC(common,isSwimming)) exitWith {false};

private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _jointArray = GET_JOINTS(_patient);
private _canStabilizeJoint = false;
private _jointGroupIndex = switch (true) do {
case (_partIndex in [4, 5]): { 0 };
case (_partIndex in [6, 7]): { 1 };
case (_partIndex in [8, 9]): { 2 };
case (_partIndex in [10, 11]): { 3 };
default { -1 };
};
private _jointCheck = (_patient getVariable [QGVAR(jointCheck), [false, false, false, false]]) select _jointGroupIndex;
if !(_jointCheck) exitWith {_canIceJoint};
if (_jointGroupIndex != -1) then {
    private _limbJointStatus = _jointArray select _jointGroupIndex;
    private _selectedJointIndexes = if (["upper", _bodyPart] call BIS_fnc_inString) then {
    [0, 1]
    } else {
    [1, 2]
    };
    {
    private _jointInjury = _limbJointStatus select _x;
    if (_jointInjury in [7, 8]) exitWith {
        _canStabilizeJoint = true;
    };
    } forEach _selectedJointIndexes;
};
_canStabilizeJoint

