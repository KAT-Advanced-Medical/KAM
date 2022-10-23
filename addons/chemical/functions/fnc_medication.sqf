#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Boddypart <STRING>
 * 3: Classname <STRING>
 * 4:
 * 5: Item <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_medication;
 *
 * Public: No
*/

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];


[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", "%1 benutzt %2", [[_medic, false, true] call ace_common_fnc_getName, getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ace_medical_treatment_fnc_addToLog;

["kat_fnc_medicationLocal", [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;

