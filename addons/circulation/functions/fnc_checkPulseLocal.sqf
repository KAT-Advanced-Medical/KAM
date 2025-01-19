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
 * [player, cursorObject, "Head"] call ace_medical_treatment_fnc_checkPulseLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _heartRate = 0;

if !([_patient, _bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) then {
    _heartRate = switch (true) do {
        case (alive _patient): {
            GET_HEART_RATE(_patient)
        };
        case (alive (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])): {
            random [100, 110, 120] // fake heart rate because patient is dead and off state machine
        };
        default { 0 };
    };
};

private _heartRateOutput = ACELSTRING(medical_treatment,Check_Pulse_Output_5);
private _logOutput = ACELSTRING(medical_treatment,Check_Pulse_None);

if (_heartRate > 1) then {
    if ([_medic, QACEGVAR(medical,numericalPulse)] call FUNC(isMedic)) then {
        if (GVAR(hardcoreDiagnose)) then {
            _heartRateOutput = LSTRING(Check_Pulse_Output);
            _logOutput = format [LLSTRING(Pulse_Output), (round(_heartRateOutput / 5) * 5)];
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

[QEGVAR(common,displayTextStructured), [[_heartRateOutput, _patient call ACEFUNC(common,getName), round _heartRate], 1.5, _medic], _medic] call CBA_fnc_targetEvent;