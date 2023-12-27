#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Painkillers Treatment
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
 * [player, cursorObject, "RightArm", classname, objNull, "kat_Painkiller"] call kat_pharma_fnc_treatmentAdvanced_Painkillers;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];
private _count1 = [_patient, "Painkillers"] call ACEFUNC(medical_status,getMedicationCount);

[_patient, _classname] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), _classname]] call ACEFUNC(medical_treatment,addToLog);
[_patient] call EFUNC(circulation,wrongBloodTreatment);
if (_count1 > 0 && GVAR(painkillerStack)) exitWith {[_patient, "Painkillers", 90, 600, 10, 0, -5] call ace_medical_status_fnc_addMedicationAdjustment};
[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
