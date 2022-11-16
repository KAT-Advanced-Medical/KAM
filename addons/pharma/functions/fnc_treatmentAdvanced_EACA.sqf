#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Handles EACA treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "EACA", objNull, "kat_EACA"] call kat_pharma_fnc_treatmentAdvanced_EACA;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", LSTRING(Activity_usedItem), [[_medic] call ace_common_fnc_getName, getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ace_medical_treatment_fnc_addToLog;
 
[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
[QGVAR(eacaLocal), [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;