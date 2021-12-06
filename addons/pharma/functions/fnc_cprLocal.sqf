#include "script_component.hpp"
/*
 * Author: Glowbal
 * Edit: Tomcat
 * Overwrites the cprLocal of ACE to add the success chance for AED and AED-X
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Used Revive Object <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "AED"] call kat_circulation_fnc_cprLocal
 *
 * Public: No
 */

params [
	["_medic",objNull,[objNull]],
	["_patient",objNull,[objNull]],
	["_reviveObject","CPR",[""]]
];

private _chance = 0;
private _random = random 100;
private _randomCPR = random 1;

switch (_reviveObject) do {
	case "CPR": {
		[_patient, "activity", "STR_ACE_medical_treatment_Activity_CPR", [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		_chance = ace_medical_treatment_cprSuccessChance;
		if (GVAR(enable_CPR_Chances)) then {
			switch (_medic getVariable ["ace_medical_medicClass",0]) do {
				case 0: {
					_chance = GVAR(CPR_Chance_Default);
				};
				case 1: {
					_chance = GVAR(CPR_Chance_RegularMedic);
				};
				case 2: {
					_chance = GVAR(CPR_Chance_Doctor);
				};
			};
		};
	};
	case "AED": {
		[_patient, "activity", "STR_ACE_Medical_Treatment_Activity_AED", [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		_chance = GVAR(SuccesCh_AED);
	};
	case "AED-Station": {
		[_patient, "activity", "STR_ACE_Medical_Treatment_Activity_AEDS", [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		_chance = GVAR(SuccesCh_AED);
	};
	case "AED-X": {
		[_patient, "activity", "STR_ACE_Medical_Treatment_Activity_AEDX", [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		_chance = GVAR(SuccesCh_AED_X);
	};
};

if (_reviveObject isEqualTo "AED" || _reviveObject isEqualTo "AED-X" || _reviveObject isEqualTo "AED-Station") exitWith {
	if (_random <= _chance) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	};
};
if !(GVAR(enable_CPR_Chances)) then {
	if (_randomCPR < _chance) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	};
} else {
	if (_random <= _chance) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	};
};



