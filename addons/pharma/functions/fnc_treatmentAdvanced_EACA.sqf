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

[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", LSTRING(Activity_usedItem), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);
 
[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
[QGVAR(eacaLocal), [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;