#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Function for inspecting catheter
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_medic, _patient] call kat_pharma_fnc_inspectCatheter;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _block = _patient getVariable [QGVAR(IVblock), false];

if (_block) exitWith {
    private _output = LLSTRING(IVblock_closed);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _output = LLSTRING(IVblock_clear);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
