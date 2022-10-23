#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins Carbonate Treatment
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
 * [player, cursorObject, "RightArm", classname, objNull, "kat_Carbonate"] call kat_pharma_fnc_treatmentAdvanced_Carbonate;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[_patient, _classname] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", LSTRING(Activity_usedItem), [[_medic] call ace_common_fnc_getName, _classname]] call ace_medical_treatment_fnc_addToLog;

[_medic, 'kat_Carbonate'] call FUNC(removeItemfromMag);
[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
[QGVAR(carbonateLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;