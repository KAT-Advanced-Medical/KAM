#include "..\script_component.hpp"
/*
 * Author: Glowbal modified by Cplhardcore
 * Local callback for checking the blood pressure of a patient.
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
 * [player, cursorObject, "LeftArm"] call kat_circulation_fnc_checkBloodPressureCuffLocal
 *
 * Public: No
 */


params ["_medic", "_patient", "_bodyPart"];

private _bloodPressure = [0, 0];

if (alive _patient && {!([_patient, _bodyPart] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo))}) then {
    _bloodPressure = [_patient] call FUNC(getBloodPressure);
};

private _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_6);
private _logOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_NoBloodpressure);

_bloodPressure params ["_bloodPressureLow", "_bloodPressureHigh"];

if (_bloodPressureHigh > 20) then {
        _bloodPressureOutput = ACELSTRING(medical_treatment,Check_Bloodpressure_Output_1);
        _logOutput = format ["%1/%2", round _bloodPressureHigh, round _bloodPressureLow];
    };

[_patient, "quick_view", ACELSTRING(medical_treatment,Check_Bloodpressure_Log), [_medic call ACEFUNC(common,getName), _logOutput]] call ACEFUNC(medical_treatment,addToLog);

[QACEGVAR(common,displayTextStructured), [[_bloodPressureOutput, _patient call ACEFUNC(common,getName), round _bloodPressureHigh, round _bloodPressureLow], 1.75, _medic], _medic] call CBA_fnc_targetEvent;