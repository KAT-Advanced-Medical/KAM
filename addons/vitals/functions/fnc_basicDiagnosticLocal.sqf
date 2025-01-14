#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local callback for checking all basic patient vitals (HR/BP/RR)
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_vitals_fnc_basicDiagnosticLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _bloodPressure = GET_BLOOD_PRESSURE(_patient);
private _hr = GET_HEART_RATE(_patient);
private _rr = GET_BREATHING_RATE(_patient);

_bloodPressure params ["_bloodPressureLow", "_bloodPressureHigh"];
_logOutput = format [LLSTRING(BasicDiagnostic_Output), _hr, _bloodPressureHigh, _bloodPressureLow, _rr];

[_patient, "quick_view", LSTRING(basicDiagnostic_Log), [_medic call ACEFUNC(common,getName), _logOutput]] call ACEFUNC(medical_treatment,addToLog);
