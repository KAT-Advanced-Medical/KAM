#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for checking the cyanosis level of a patient.
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
 * [player, cursorObject, "Head"] call kat_breathing_fnc_checkCyanosisLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _spO2 = 0;

if (alive _patient) then {
    _spO2 = _patient getVariable ["KAT_medical_airwayStatus", 100];
};

private _spO2Output = LSTRING(CyanosisStatus_N);

if (_spO2 < 100) then {
    if (_spO2 < 99 && _spO2 >= 1.66 * {GVAR(dieValue)}) then {
        _spO2Output = LSTRING(CyanosisStatus_Slight);
    };
    if (_spO2 < 1.66 * {GVAR(dieValue)} && _spO2 >= 1.33 * {GVAR(dieValue)}) then {
        _spO2Output = LSTRING(CyanosisStatus_Mild);
    };
    if (_spO2 < 1.33 * {GVAR(dieValue)} && _spO2 >= 1.01 * {GVAR(dieValue)}) then {
        _spO2Output = LSTRING(CyanosisStatus_Severe);
    };

};

[_SpO2Output, 2, _player] call ace_common_fnc_displayTextStructured;

[_patient, "activity", LSTRING(CheckCyanosise_Log), [_medic call ace_common_fnc_getName, _spO2Output]] call ace_medical_treatment_fnc_addToLog;