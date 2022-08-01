#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Checks patient's PH levels
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_surgery_fnc_inspectBreath;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _ph = _patient getVariable [QGVAR(ph), 1500];

if (_ph > 750) exitWith {
    private _output = localize LSTRING(breath_good);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

if (_ph > 250) exitWith {
    private _output = localize LSTRING(breath_mild);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _output = localize LSTRING(breath_stink);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;