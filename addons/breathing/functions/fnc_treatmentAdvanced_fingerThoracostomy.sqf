#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Treatment for hemopneumothorax/tensionPnumo
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <Number>
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1] call kat_breathing_fnc_treatmentAdvanced_fingerThoracostomy;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(fingerThoracostomyLocal), [_medic, _patient, _side], _patient] call CBA_fnc_targetEvent;
