#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Adds Medication to patient's logs
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_GenericLocal;
 *
 * Public: No
 */

params ["_target", "_medic", "_item"];

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(push_log), [[_medic] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;

true