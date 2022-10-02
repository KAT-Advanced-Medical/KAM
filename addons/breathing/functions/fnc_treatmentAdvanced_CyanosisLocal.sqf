#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for checking the cyanosis level of a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_checkCyanosisLocal
 *
 * Public: No
 */

params ["_player", "_target"];

private _spO2 = 0;

if (alive _target) then {
    _spO2 = _patient getVariable ["KAT_medical_airwayStatus", 100];
};

private _messageCyanosis = LLSTRING(CyanosisStatus_N);
private _spO2Output = LSTRING(CyanosisStatus_N);

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

private _message = format ["%1",_messageCyanosis];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;

[_target, "quick_view", LSTRING(CheckCyanosis_Log), [_spO2Output]] call ace_medical_treatment_fnc_addToLog;