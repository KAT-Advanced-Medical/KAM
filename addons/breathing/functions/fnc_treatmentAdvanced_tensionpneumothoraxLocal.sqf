#include "script_component.hpp"
/*
 * Author: Kygan, modified by YetheSamartaka
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

params ["_player", "_target"];
// systemChat "Executing Hemopneumothorax Treatment local";

_target getVariable ["KAT_medical_tensionpneumothorax", false];

if (kat_breathing_tensionhemothorax_hardcore == false) then {
	if ((_target getVariable ["KAT_medical_tensionpneumothorax", false]) && (_target getVariable ["KAT_medical_activeChestSeal", false]) ) then {
	[_target, "activity", LSTRING(tensionpneumothorax), [[_player] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
	};
};

if (_target getVariable ["KAT_medical_activeChestSeal", false]) then {
	_target setVariable ["KAT_medical_tensionpneumothorax", false, true];
};

if ((_target getVariable ["KAT_medical_pneumothorax", false]) && (_target getVariable ["KAT_medical_hemopneumothorax", false]) && (_target getVariable ["KAT_medical_tensionpneumothorax", false]) ) then {
	_target setVariable ["KAT_medical_activeChestSeal", false, true];	
};