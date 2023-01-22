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

private _ph = _patient getVariable [QGVAR(pH), 1500];
private _hr = GET_HEART_RATE(_patient);
private _output = LLSTRING(breath_stink);

if (_ph > 250) then {
    _output = LLSTRING(breath_mild);
};

if (_ph > 750) then {
    _output = LLSTRING(breath_good);
};

if (_hr == 0 || !(alive _patient)) then {
    _output = LLSTRING(breath_none);
};

[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
