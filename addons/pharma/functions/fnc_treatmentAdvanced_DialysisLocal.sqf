#include "..\script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local treatment call for dialysis procedure
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_DialysisLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];
/*
 * Performs dialysis over 5 minutes.
 * Fails if patient moves or changes seat/vehicle.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 */

params ["_medic", "_patient"];

if (isNull _patient || !alive _patient) exitWith {};
if (_patient getVariable [QGVAR(dialysisRunning), false]) exitWith {};
private _startVeh  = vehicle _patient;
_patient setVariable [QGVAR(dialysisRunning), true, true];
[_patient, "activity", LSTRING(dialysis_Start), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[{
    params ["_patient", "_startVeh"];
    (!alive _patient) || (abs (speed _patient) > 1 && isNull objectParent _patient) || ((vehicle _patient) != _startVeh);
}, {
    [_patient, "activity", LSTRING(dialysis_Failed), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
}, [_patient, _startVeh], 300, {
    params ["_patient"];
    _patient setVariable [QACEGVAR(medical,medications), [], true];
    _patient setVariable [QGVAR(externalPh), 0, true];
    _patient setVariable [QGVAR(kidneyFail), false, true];
    _patient setVariable [QGVAR(kidneyArrest), false, true];
    _patient setVariable [QGVAR(kidneyPressure), false, true];
    _patient setVariable [QGVAR(serumCalcium), 2.4, true];
    _patient setVariable [QGVAR(externalCa), 0, true];
    _patient setVariable [QGVAR(dialysisRunning), false, true];
    [_patient, "Dialysis"] call ACEFUNC(medical_treatment,addToTriageCard);
    [_patient, "activity", LSTRING(dialysis_Finished), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
}] call CBA_fnc_waitUntilAndExecute;
