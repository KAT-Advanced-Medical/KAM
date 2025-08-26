#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Local callback for checking the pulse or heart rate of a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head"] call kat_circulation_fnc_checkPulseLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _heartRate = 0;
private _tourniquets = GET_TOURNIQUETS(_patient);
private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];
private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _idx = _occlusionMap findIf { _x#0 == _part };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isOccluded = { _tourniquets select _x != 0 } count _result > 0;

if !(_isOccluded) then {
    _heartRate = switch (true) do {
        case (alive _patient): {
            GET_HEART_RATE(_patient)
        };
        case ((_patient getVariable [QGVAR(attachedLucasState), false])): {
            100 // fake heart rate because patient is dead and off state machine
        };
        case (alive (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])): {
            random [90, 100, 120] // fake heart rate because patient is dead and off state machine
        };
        default { 0 };
    };
};

private _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_5);
private _logOutput = ACELSTRING(medical_treatment,Check_Pulse_None);

if (_heartRate > 1) then {
    if ([_medic, ACEGVAR(medical_treatment,numericalPulse)] call ACEFUNC(common,isMedic)) then {
        if (GVAR(hardcoreDiagnose)) then {
            _heartRateOutput = LSTRING(Check_Pulse_Output);
            _heartRate = (round(_heartRate / 5) * 5);
            _logOutput = format [LLSTRING(Pulse_Output), _heartRate];
        } else {
            _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_1);
            _logOutput = str round _heartRate;
        };
    } else {
        _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_2);
        _logOutput = ACELSTRING(medical_treatment,Check_Pulse_Weak);

        if (_heartRate > 60) then {
            if (_heartRate > 100) then {
                _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_3);
                _logOutput = ACELSTRING(medical_treatment,Check_Pulse_Strong);
            } else {
                _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_4);
                _logOutput = ACELSTRING(medical_treatment,Check_Pulse_Normal);
            };
        };
    };
};
[_patient, "quick_view", ACELSTRING(medical_treatment,Check_Pulse_Log), [_medic call ACEFUNC(common,getName), _logOutput]] call ACEFUNC(medical_treatment,addToLog);
[QACEGVAR(common,displayTextStructured), [[_heartRateOutput, _patient call ACEFUNC(common,getName), round _heartRate], 1.5, _medic], _medic] call CBA_fnc_targetEvent;