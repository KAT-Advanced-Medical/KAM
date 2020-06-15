#include "script_component.hpp"
/*
 * Author: Glowbal
 * Overwrites the cprLocal of ACE to add the success chance for AED and AED-X
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_cprLocal
 *
 * Public: No
 */

params [
	["_medic",objNull,[objNull]],
	["_patient",objNull,[objNull]],
	["_reviveObject","CPR",[""]]
];

private _chance = 0;

switch (_reviveObject) do {
	case "CPR": {
		[_patient, "activity", "STR_ACE_medical_treatment_Activity_CPR", [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
		_chance = ace_medical_treatment_cprSuccessChance;
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
	if (random 100 <= _chance) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	};
};

if ((random 1) < _chance) then {
    ["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
};