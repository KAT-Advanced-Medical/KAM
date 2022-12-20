#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for checking the cyanosis level of a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_CyanosisLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _spO2 = 0;

if (alive _patient) then {
    _spO2 = _patient getVariable [QGVAR(airwayStatus), 100];
};

private _messageCyanosis = LLSTRING(CyanosisStatus_N);
private _spO2Output = LSTRING(CyanosisStatus_N);

[_patient, "quick_view", "STR_kat_breathing_CheckCyanosis_Log"] call EFUNC(circulation,removeLog);

if (!([_patient,_bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo))) then {
    
    if (_spO2 <= GVAR(slightValue)) then {
        _spO2Output = LSTRING(CyanosisStatus_Slight);
        _messageCyanosis = LLSTRING(CyanosisStatus_Slight);
    };

    if (_spO2 <= GVAR(mildValue)) then {
        _spO2Output = LSTRING(CyanosisStatus_Mild);
        _messageCyanosis = LLSTRING(CyanosisStatus_Mild);
    };

    if (_spO2 <= GVAR(severeValue)) then {
        _spO2Output = LSTRING(CyanosisStatus_Severe);
        _messageCyanosis = LLSTRING(CyanosisStatus_Severe);
    };
} else {
    _spO2Output = LSTRING(CyanosisStatus_Severe);
    _messageCyanosis = LLSTRING(CyanosisStatus_Severe);
};

private _message = format ["%1",_messageCyanosis];
[_message, 2, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(CheckCyanosis_Log), [_spO2Output]] call ACEFUNC(medical_treatment,addToLog);