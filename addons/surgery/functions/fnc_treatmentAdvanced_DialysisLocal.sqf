#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Locates and Removes 1x Morphine after the administration of Naloxone.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Naloxone"] call aceP_circulation_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable ["ace_medical_medications", [], true];
_patient setVariable [QGVAR(pH), 1000, true];
_patient setVariable [QGVAR(kidneyFail), false, true];
_patient setVariable [QGVAR(kidneyArrest), false, true];
_patient setVariable [QGVAR(kidneyPressure), false, true];

[_patient, "Dialysis"] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", LSTRING(dialysis_log), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;