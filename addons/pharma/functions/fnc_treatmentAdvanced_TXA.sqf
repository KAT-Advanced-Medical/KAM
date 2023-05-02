#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins TXA Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "TXA", objNull, "kat_TXA"] call kat_pharma_fnc_treatmentAdvanced_TXA;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
[QGVAR(txaLocal), [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
