#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the placement of the eye shield.
 * The shield itself is applied where the patient is local.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyeShield
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(eyeShieldLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;

[_patient, LLSTRING(eyeshield_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyeshield_item)]] call ACEFUNC(medical_treatment,addToLog);
