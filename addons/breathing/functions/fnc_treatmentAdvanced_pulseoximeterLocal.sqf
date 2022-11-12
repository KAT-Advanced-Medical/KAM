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

    if (([_patient,_bodyPart] call ace_medical_treatment_fnc_hasTourniquetAppliedTo)) then {
        _HR = 0;
        _SpO2 = 0;
    };


    [_patient, "quick_view", LSTRING(pulseoxi_Log)] call EFUNC(circulation,removeLog);
    [_patient, "quick_view", LSTRING(pulseoxi_Log), [round _HR, round _SpO2]] call ace_medical_treatment_fnc_addToLog;
}, 1, [_patient, _bodyPart]] call CBA_fnc_addPerFrameHandler;

[_patient, "quick_view", LSTRING(pulseoxi_Log), [round _HR, round _SpO2]] call ace_medical_treatment_fnc_addToLog;
[_patient, "activity", LSTRING(pulseoxi_Log_2), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
[_patient, "Pulseoximeter"] call ace_medical_treatment_fnc_addToTriageCard;
