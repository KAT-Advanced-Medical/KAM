#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Radiation survey diagnostic: reads a patient's external (surface)
 * contamination level, dominant radiation type, and ambient dose-rate from the
 * dosimeter and reports them to the examining medic.
 *
 * Runs on the medic's machine (treatment callbackSuccess).
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _contam = _patient getVariable [QGVAR(radExternalContam), 0];
private _type = _patient getVariable [QGVAR(radDominantType), ""];
private _rate = _patient getVariable [QGVAR(radDoseRate), 0];

private _typeText = if (_type isEqualTo "") then { LLSTRING(radSurvey_none) } else { _type };

private _text = format [
    "%1<br/>%2<br/>%3",
    format [LLSTRING(radSurvey_contam), round (_contam * 100)],
    format [LLSTRING(radSurvey_rate), _rate toFixed 3],
    format [LLSTRING(radSurvey_type), _typeText]
];

[_text, 2, _medic] call ACEFUNC(common,displayTextStructured);
