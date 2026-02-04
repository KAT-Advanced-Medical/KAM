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
private _height = 1.5;
private _breathing = LLSTRING(breathing_isNormal);
private _breathing_log = localize ACELSTRING(medical_treatment,Check_Pulse_Normal);
private _breath = "";
private _breathRate = "RR: ";


private _respiratoryDepth = _patient getVariable [QEGVAR(vitals,respiratoryDepth), 10];
if (_respiratoryDepth < 9) then {
    _breathing = LLSTRING(breathing_isShallow);
    _breathing_log = LLSTRING(breathing_shallow);
};

if (_respiratoryDepth < 7)  then {
    _breathing = LLSTRING(breathing_isVeryShallow);
    _breathing_log = LLSTRING(breathing_Veryshallow);
};

if (_ph < 7.3) then {
    _breath = LLSTRING(breath_mild);

    if (_ph < 7.1) then {
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
private _breathingState = _patient getVariable [QEGVAR(vitals,breathingState), 0];
private _isMedic = [_medic, GVAR(medLvl_VerboseBreathing)] call ACEFUNC(common,isMedic);
if ((GVAR(enableVerboseBreathing)) && _isMedic)then {
    switch (_breathingState) do {
        case 1: {
            private _breathing_alt = LLSTRING(breathing_isCheyne);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 2: {
            private _breathing_alt = LLSTRING(breathing_isIrreg);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 3: {
            private _breathing_alt = LLSTRING(breathing_isBiots);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 4: {
            private _breathing_alt = LLSTRING(breathing_isAgonal);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 5: {
            private _breathing_alt = LLSTRING(breathing_isKussmaul);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 6: {
            private _breathing_alt = LLSTRING(breathing_isKussmaulFailure);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 7: {
            private _breathing_alt = LLSTRING(breathing_isRespFailure1);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 8: {
            private _breathing_alt = LLSTRING(breathing_isRespFailure2);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        case 9: {
            private _breathing_alt = LLSTRING(breathing_isRespFailure3);
            _output = format ["%1%2, %3, %4", _breathing ,_breath, _breathRate, _breathing_alt];
            _height = 3;
        };
        default {
            _output = format ["%1%2, %3", _breathing ,_breath, _breathRate];
            _height = 3;
        }
    };
};


private _isbreathing = true;
private _paralysis = _patient getVariable [QGVAR(paralysis), 0] > 0.1;
if ((_rawRR < 1) || _paralysis) then {
    _isbreathing = false;
};
private _airway = HAS_AIRWAY(_patient);
if (_hr == 0 || !(alive _patient) || !_airway || !_isbreathing || _rr == 0) then {
    _output = LLSTRING(breathing_none);
    _output_log = ACELSTRING(medical_treatment,Check_Pulse_None);
};

[_output, _height, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(CheckBreathing_Log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(CheckBreathing_Log), [[_medic] call ACEFUNC(common,getName), _output_log]] call ACEFUNC(medical_treatment,addToLog);
