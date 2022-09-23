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
private _output = LLSTRING(breath_stink);

if (_ph > 750) then {
    private _output = LLSTRING(breath_good);
};

if (_ph > 250) then {
    private _output = LLSTRING(breath_mild);
};


[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;