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

private _ph = GET_PH(_patient);
private _hr = GET_HEART_RATE(_patient);
private _rawRR = GET_BREATHING_RATE(_patient);
private _rr = round _rawRR;
private _output = "";
private _output_log = "";

private _breathing = LLSTRING(breathing_isNormal);
private _breathing_log = localize ACELSTRING(medical_treatment,Check_Pulse_Normal);
private _breath = "";
private _breathRate = "RR: ";


private _respiratoryDepth = _patient getVariable [QEGVAR(vitals,respiratoryDepth), 10];
if (_respiratoryDepth < 8.5) then {
    _breathing = LLSTRING(breathing_isShallow);
    _breathing_log = LLSTRING(breathing_shallow);
};

if (_respiratoryDepth < 7)  then {
    _breathing = LLSTRING(breathing_isVeryShallow);
    _breathing_log = LLSTRING(breathing_Veryshallow);
};

if (_ph < 7.2) then {
    _breath = LLSTRING(breath_mild);

    if (_ph < 6.9) then {
        _breath = LLSTRING(breath_stink);
    };
};

if ([_medic] call ACEFUNC(common,isMedic)) then {
    _breathRate = format ["%1%2", _breathRate, _rr];
} else {
    switch (true) do {
        case (_rr > 25): { _breathRate = LLSTRING(breathing_rrRapid); };
        case (_rr < 11): { _breathRate = LLSTRING(breathing_rrSlow); };
        default { _breathRate = LLSTRING(breathing_rrNormal); };
    };
};

_output = format ["%1%2, %3", _breathing ,_breath, _breathRate];
_output_log = format ["%1%2, %3", _breathing_log, _breath, _breathRate];

private _breathing = true;
private _paralysis = _patient getVariable [QGVAR(paralysis), 0] > 0.1;
if ((_rawRR < 1) || _paralysis) then {
    _breathing = false;
};
private _airway = HAS_AIRWAY(_patient);
if (_hr == 0 || !(alive _patient) || !_airway || !_breathing || _rr == 0) then {
    _output = LLSTRING(breathing_none);
    _output_log = ACELSTRING(medical_treatment,Check_Pulse_None);
};

[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(CheckBreathing_Log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(CheckBreathing_Log), [[_medic] call ACEFUNC(common,getName), _output_log]] call ACEFUNC(medical_treatment,addToLog);
