#include "..\script_component.hpp"
/*
 * Author: Mazinski
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
 * [player, cursorTarget] call kat_surgery_fnc_treatmentAdvanced_DialysisLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QACEGVAR(medical,medications), [], true];
_patient setVariable [QGVAR(pH), 1000, true];
_patient setVariable [QGVAR(kidneyFail), false, true];
_patient setVariable [QGVAR(kidneyArrest), false, true];
_patient setVariable [QGVAR(kidneyPressure), false, true];

[_patient, "Dialysis"] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", LSTRING(dialysis_log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
