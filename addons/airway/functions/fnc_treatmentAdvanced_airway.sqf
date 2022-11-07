#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus"] call kat_airway_fnc_treatmentAdvanced_airway;
 *
 * Public: No
 */

params ["_medic", "_patient", "_usedItem"];

[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", LSTRING(airway_log), [[_medic] call ace_common_fnc_getName, _usedItem]] call ace_medical_treatment_fnc_addToLog;
[_patient, "activity_view", LSTRING(airway_log), [[_medic] call ace_common_fnc_getName, _usedItem]] call ace_medical_treatment_fnc_addToLog;

[QGVAR(airwayLocal), [_medic, _patient, _usedItem], _patient] call CBA_fnc_targetEvent;
