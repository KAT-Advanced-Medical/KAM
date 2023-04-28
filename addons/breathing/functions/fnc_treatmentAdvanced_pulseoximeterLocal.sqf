#include "script_component.hpp"
/*
 * Author: Katalam
 * Puts a pulseoximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "LeftArm"] call kat_breathing_fnc_treatmentAdvanced_pulseoximeterLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (_patient getVariable ["kat_PulseoxiInUse_PFH", false]) exitWith {};
_patient setVariable ["kat_PulseoxiInUse_PFH", true];

_patient setVariable [QGVAR(pulseoximeter), true, true];
_patient setVariable [QGVAR(PulseOximeter_VolumePatient), _medic getVariable QGVAR(PulseOximeter_Volume), true];


private _attachedPulseOximeter = _patient getVariable [QGVAR(PulseOximeter_Attached), [0,0]];
_attachedPulseOximeter set [(ALL_BODY_PARTS find toLower _bodyPart)-2,1];
_patient setVariable [QGVAR(PulseOximeter_Attached), _attachedPulseOximeter, true];

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_bodyPart"];
    if !(_patient getVariable [QGVAR(pulseoximeter), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable ["kat_PulseoxiInUse_PFH", nil];
        [_patient, "quick_view", LSTRING(pulseoxi_Log)] call EFUNC(circulation,removeLog);
    };

    private _HR = GET_HEART_RATE(_patient);
    private _SpO2 = _patient getVariable [QGVAR(airwayStatus), 100];

    if (([_patient,_bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo))) then {
        _HR = 0;
        _SpO2 = 0;
    };

    [_patient, "quick_view", LSTRING(pulseoxi_Log)] call EFUNC(circulation,removeLog);
    [_patient, "quick_view", LSTRING(pulseoxi_Log), [round _HR, round _SpO2]] call ACEFUNC(medical_treatment,addToLog);
}, 1, [_patient, _bodyPart]] call CBA_fnc_addPerFrameHandler;

[{
    params ["_args", "_idPFH"];
    _args params ["_patient", "_bodyPart"];
    if !(_patient getVariable [QGVAR(pulseoximeter), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _SpO2 = _patient getVariable [QGVAR(airwayStatus), 100];

    if (([_patient,_bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo))) then {
        _SpO2 = 0;
    };

    if(_patient getVariable [QGVAR(PulseOximeter_VolumePatient), false] && _SpO2 < GVAR(PulseOximeter_SpO2Warning)) then {
        playSound3D [QPATHTOF_SOUND(audio\pulseoximeter_warning.wav), _patient, false, getPosASL _patient, 4, 1, 15];
    };
}, 3, [_patient, _bodyPart]] call CBA_fnc_addPerFrameHandler;

[_patient, "activity", LSTRING(pulseoxi_Log_2), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
