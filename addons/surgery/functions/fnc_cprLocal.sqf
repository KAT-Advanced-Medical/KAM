#include "script_component.hpp"
/*
 * Author: Glowbal
 * Edit: Tomcat
 * Edit: TheSavageCoder
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

// String identifier for the activity that was performed. Empty string means no activity taken.
private _activity = "";
// Indicates if our activity was successful or not
private _success = false;

// Calculates random success based on an integer chance between 0 and 100
private _randomSuccess = {
	params ["_chance"];
	(random 100) <= _chance;
};

switch (_reviveObject) do {
	case "CPR": {
		_activity = "STR_ACE_medical_treatment_Activity_CPR";

		// Check if medic class based CPR chances are enabled
		if (GVAR(enable_CPR_Chances)) then {
			switch (_medic getVariable ["ace_medical_medicClass",0]) do {
				case 0: {
					_success = GVAR(CPR_Chance_Default) call _randomSuccess;
				};
				case 1: {
					_success = GVAR(CPR_Chance_RegularMedic) call _randomSuccess;
				};
				case 2: {
					_success = GVAR(CPR_Chance_Doctor) call _randomSuccess;
				};
			};
		} else {
			/*
				Fallback to same calculation of chance as ACE Medical Treatment's cprLocal
				SEE: https://github.com/acemod/ACE3/blob/master/addons/medical_treatment/functions/fnc_cprLocal.sqf

				BLOOD_VOLUME_CLASS_* and GET_BLOOD_VOLUME() macros are imported from the ACE medical_engine script macros
			*/
			private _min = ace_medical_treatment_cprSuccessChanceMin;
			private _max = ace_medical_treatment_cprSuccessChanceMax;
			private _chance = linearConversion [BLOOD_VOLUME_CLASS_4_HEMORRHAGE, BLOOD_VOLUME_CLASS_2_HEMORRHAGE, GET_BLOOD_VOLUME(_patient), _min, _max, true];
			// ACE Medical settings are percentages (decimals, 0 <= x <= 1) instead of integers
			_success = (random 1) < _chance;
		};
	};
	case "AED": {
		_activity = "STR_ACEP_circulation_Activity_AED";
		_success = GVAR(SuccesCh_AED) call _randomSuccess;
	};
	case "AED-Station": {
		_activity = "STR_ACEP_circulation_Activity_AEDS";
		_success = GVAR(SuccesCh_AED) call _randomSuccess;
	};
	case "AED-X": {
		_activity = "STR_ACEP_circulation_Activity_AEDX";
		_success = GVAR(SuccesCh_AED_X) call _randomSuccess;
	};
};

// If an activity was performed, log it and check if CPR was successful.
if (_activity != "") exitWith {
	[_patient, "activity", _activity, [[_medic, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
	if (_success) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
        _patient setVariable [QGVAR(kidneyArrest), false, true];
	};
};
