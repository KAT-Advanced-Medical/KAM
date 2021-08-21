#include "script_component.hpp"
/*
 * Author: Katalam, modified by Kygan and YetheSamartaka
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

params ["_player", "_target"];

if (_target getVariable ["KAT_medical_pneumothorax", false]) then {
	_target setVariable ["KAT_medical_activeChestSeal", true, true];
};

if (kat_breathing_pneumothorax_hardcore == false) then {
	if (_target getVariable ["KAT_medical_pneumothorax", false]) then {
	[_target, "activity", LSTRING(pneumothorax), [[_player] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
	};
};

_target setVariable ["KAT_medical_pneumothorax", false, true];

if (random 100 <= GVAR(hemopneumothoraxChance)) then {
	_unit setVariable ["KAT_medical_hemopneumothorax", true, true];
};

if ((_target getVariable ["KAT_medical_pneumothorax", false]) && (_target getVariable ["KAT_medical_hemopneumothorax", false]) && (_target getVariable ["KAT_medical_tensionpneumothorax", false]) ) then {
	_target setVariable ["KAT_medical_activeChestSeal", false, true];	
};