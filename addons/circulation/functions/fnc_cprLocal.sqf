#include "script_component.hpp"
/*
 * Author: Glowbal, Mazinski.H
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

private _bloodLoss = _patient getVariable ["ace_medical_bloodVolume", 6.0];
private _medicationArray = _patient getVariable ["ace_medical_medications", []];

private _chance = 0;
private _random = random 100;
private _randomAmi = random 4;
private _randomCPR = random 1;
private _epiBoost = 0;
private _amiBoost = 0;
private _lidoBoost = 0;
private _asystole = _patient getVariable [QGVAR(asystole), 0];
private _CPRcount = _patient getVariable [QGVAR(CPRcount), 0];

if (_asystole == 0) then {
	if (_bloodLoss <= 2.8) then {
		_patient setVariable [QGVAR(asystole), 2, true];
		_asystole = _patient getVariable [QGVAR(asystole), 2];
	} else {
		_patient setVariable [QGVAR(asystole), 1, true];
		_asystole = _patient getVariable [QGVAR(asystole), 1];
	};
};

{
    _x params ["_medication"];

    switch(_medication) do
    {
	    case "Epinephrine": 
	    {
	    _epiBoost = 1;
	    };
	    case "Amiodarone": 
	    {
	    _amiBoost = _amiBoost + (random [8,14,20]);
	    	if (_randomAmi >= 2) then {
	    	    [_patient, "BRADYCARDIA", 120, 1200, -15, 0, 0] call ace_medical_status_fnc_addMedicationAdjustment;
	    	};
	    };
	    case "Lidocane": 
	    {
	    _lidoBoost = _lidoBoost + 8;
	    };
	};
} forEach (_patient getVariable ["ace_medical_medications", []]);

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
	_chance = _chance + (_amiBoost + _lidoBoost * _epiBoost);
	if (_random <= _chance && {_asystole <= 1}) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
		_patient setVariable [QGVAR(asystole), 0, true];
	};
};
if !(GVAR(enable_CPR_Chances)) then {
	if (_random < _chance) then {
		["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	};
} else {
	if (_epiBoost isEqualTo 1) then {
		_chance = _chance + (2 ^ _CPRcount);
		_CPRcount = _CPRcount + 1;
		_patient setVariable [QGVAR(CPRcount), _CPRcount, true];
	};

	if (_random <= _chance) then {
		if (_randomAmi > 1) then {
			_patient setVariable [QGVAR(asystole), 1, true];
			_patient setVariable [QGVAR(CPRcount), 2, true];
		} else {
			["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
			_patient setVariable [QGVAR(asystole), 0, true];
			_patient setVariable [QGVAR(CPRcount), 2, true];
		};
	};
};