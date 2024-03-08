#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Function for inspecting catheter
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
 * [_medic, _patient, "LeftArm"] call kat_pharma_fnc_inspectCatheter;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

if (_IVactual == 3) exitWith {
    private _output = LLSTRING(IVblock_closed);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

private _output = LLSTRING(IVblock_clear);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
