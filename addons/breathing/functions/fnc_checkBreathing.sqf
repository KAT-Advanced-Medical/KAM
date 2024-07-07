#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Modified: Blue
 * Check how patient is breathing and the patient's PH levels
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_breathing_fnc_checkBreathing;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _ph = _patient getVariable [QEGVAR(pharma,pH), 1500];
private _hr = GET_HEART_RATE(_patient);
private _output = "";
private _output_log = "";

private _breathing = LLSTRING(breathing_isNormal);
private _breathing_log = localize ACELSTRING(medical_treatment,Check_Pulse_Normal);
private _breath = "";

if (_patient getVariable [QGVAR(pneumothorax), 0] > 0) then {
    _breathing = LLSTRING(breathing_isShallow);
    _breathing_log = LLSTRING(breathing_shallow);
};

if (_ph < 750) then {
    _breath = LLSTRING(breath_mild);

    if (_ph < 250) then {
        _breath = LLSTRING(breath_stink);
    };
};

_output = format ["%1%2", _breathing ,_breath];
_output_log = format ["%1%2", _breathing_log, _breath];

if (_hr == 0 || !(alive _patient) || (_patient getVariable [QEGVAR(airway,obstruction), false] && !(_patient getVariable [QEGVAR(airway,overstretch), false])) || _patient getVariable [QEGVAR(airway,occluded), false] || _patient getVariable [QGVAR(hemopneumothorax), false] || _patient getVariable [QGVAR(tensionpneumothorax), false]) then {
    _output = LLSTRING(breathing_none);
    _output_log = ACELSTRING(medical_treatment,Check_Pulse_None);
};

[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(CheckBreathing_Log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(CheckBreathing_Log), [[_medic] call ACEFUNC(common,getName), _output_log]] call ACEFUNC(medical_treatment,addToLog);
