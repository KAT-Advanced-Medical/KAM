#include "script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka and Tomcat.
 * Treatment for hemopneumothorax
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_hemopneumothoraxLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(kat_breathing_tensionhemothorax_hardcore) exitWith {
	if ((_patient getVariable ["KAT_medical_hemopneumothorax", false]) && {_patient getVariable ["KAT_medical_activeChestSeal", false]}) then {
		_patient setVariable ["KAT_medical_hemopneumothorax", false, true];
		[_patient, "activity", LSTRING(hemopneumothorax), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		if (!(_patient getVariable ["KAT_medical_pneumothorax", false]) && {!(_patient getVariable ["KAT_medical_hemopneumothorax", false]) && {!(_patient getVariable ["KAT_medical_tensionpneumothorax", false])}}) then {
			_patient setVariable ["KAT_medical_activeChestSeal", false, true];
		};
	};
};

if (_patient getVariable ["KAT_medical_activeChestSeal", false]) then {
	_patient setVariable ["KAT_medical_hemopneumothorax", false, true];
};

if (!(_patient getVariable ["KAT_medical_pneumothorax", false]) && {!(_patient getVariable ["KAT_medical_hemopneumothorax", false]) && {!(_patient getVariable ["KAT_medical_tensionpneumothorax", false])}}) then {
	_patient setVariable ["KAT_medical_activeChestSeal", false, true];
};
