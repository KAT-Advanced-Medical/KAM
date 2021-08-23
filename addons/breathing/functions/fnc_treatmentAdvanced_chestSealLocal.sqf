#include "script_component.hpp"
/*
 * Author: Katalam, modified by Kygan, YetheSamartaka and Tomcat.
 * handles chest seal treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_treatmentAdvanced_chestSealLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable ["KAT_medical_activeChestSeal", true, true];

_fnc_random = {
	if (random 100 <= GVAR(hemopneumothoraxChance)) then {
		_patient setVariable ["KAT_medical_hemopneumothorax", true, true];
	};
};

if !(kat_breathing_pneumothorax_hardcore) exitWith {
	if (_patient getVariable ["KAT_medical_pneumothorax", false]) then {
		_patient setVariable ["KAT_medical_pneumothorax", false, true];
		[_patient, "activity", LSTRING(pneumothorax), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		call _fnc_random;
		if (!(_patient getVariable ["KAT_medical_pneumothorax", false]) && {!(_patient getVariable ["KAT_medical_hemopneumothorax", false]) && {!(_patient getVariable ["KAT_medical_tensionpneumothorax", false])}}) then {
			_patient setVariable ["KAT_medical_activeChestSeal", false, true];
		};
	};
};

_patient setVariable ["KAT_medical_pneumothorax", false, true];

if (!(_patient getVariable ["KAT_medical_pneumothorax", false]) && {!(_patient getVariable ["KAT_medical_hemopneumothorax", false]) && {!(_patient getVariable ["KAT_medical_tensionpneumothorax", false])}}) then {
	_patient setVariable ["KAT_medical_activeChestSeal", false, true];
};
