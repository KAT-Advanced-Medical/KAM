#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Nalbuphine Treatment
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
 * [player, cursorObject, "RightArm", "Nalbuphine", objNull, "kat_nalbuphine"] call kat_pharma_fnc_treatmentAdvanced_Nalbuphine;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;
[_patient, "activity", LSTRING(Activity_usedItem), [[_medic] call ace_common_fnc_getName, getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ace_medical_treatment_fnc_addToLog;
 
[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
if (GVAR(nalbuphineEnable)) then {
	[_patient, true] call FUNC(effectNalbuphine);
};
