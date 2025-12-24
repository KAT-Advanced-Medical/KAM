#include "..\script_component.hpp"
/*
 * Author: M3ales
 * Builds a set of subactions for a given passenger, listing their afflictions.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Parameters <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [_player,_target,[_patient]] call MIRA_fnc_buildUnstableActions
 *
 * Public: Yes
 */

params["_target", "_player", "_parameters"];

_parameters params [
	"_patient"
];

private _actions = [];
private _isMedic = (_player call ACEFUNC(medical_treatment,isMedic));

// Dead
private _isDead = GVAR(Unstable_TrackDead) && !alive _patient;
if(_isDead) then {
	private _action = ["MIRA_Dead", [LOC(Unstable,Dead)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\dead.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
			if(GVAR(WarnViewingDead)) then {
				private _patientName = [_patient] call ace_common_fnc_getName;
				[format[[LOC(Unstable,Dead_Warning)] call FUNC(cachedLocalisationCall), _patientName], true, 4, 1] call ACE_common_fnc_displayText;
			};
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

private _canTakeDogtag = GVAR(Unstable_TakeDogtags) && [_player, _patient] call ace_dogtags_fnc_canTakeDogtag;
// Take Dogtags Action
if(_canTakeDogtag && {(GVAR(Unstable_DogtagsDeadOnly) && !alive _patient) || !GVAR(Unstable_DogtagsDeadOnly)}) then {
	private _taken = [LOC(Unstable,Dogtags_Take)] call FUNC(cachedLocalisationCall);
	if(_patient getVariable["ace_dogtags_dogtagTaken", objNull] == _target) then {
		_taken =  [LOC(Unstable,Dogtags_Already_Taken)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Dogtags_Take", _taken, QPATHTOF(ui\dogtags.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_player, _patient] call ace_dogtags_fnc_takeDogtag;
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Cardiac Arrest Action
private _cardiacArrest = GVAR(Unstable_TrackCardiacArrest) && (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] != 0);
if (_cardiacArrest) then {
	_action = ["MIRA_Cardiac", [LOC(Unstable,Cardiac_Arrest)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\cardiac_arrest_red.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// KAT Integration Actions

private _spO2 = GET_KAT_SPO2(_patient);
if(GVAR(Unstable_TrackSpO2) && _spO2 < 90) then {
	_action = ["MIRA_KAT_SpO2", format[[LOC(Unstable_KAT,SpO2)] call FUNC(cachedLocalisationCall), round _spO2, "%"], QPATHTOF(ui\kat_spO2_low.paa), {
		params ["_target", "_player", "_parameters"];
		_parameters params ["_patient"];
		[_patient] call FUNC(openMedicalMenu);
	}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};


// Bleeding Action
private _isBleeding = GVAR(Unstable_TrackBleeding) && _patient call FUNC(needsBandage);
//add bleeding action if applicable
if (_isBleeding) then {
	//TODO: collect all wounds, and colour icon based on severity, only have red done for now
	_action = ["MIRA_Bleeding", [LOC(Unstable,Bleeding)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\bleeding_red.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low HeartRate Action
private _hasLowHR = GVAR(Stable_TrackLowHR) && (GET_HEART_RATE(_patient) < 60);
if(_hasLowHR) then {
	private _hr = [_patient, _isMedic] call FUNC(displayHR);
	private _action = ["MIRA_LowHR", format[[LOC(Stable,Low_Heart_Rate)] call FUNC(cachedLocalisationCall), _hr], QPATHTOF(ui\hr_low.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Blood Pressure Action
private _bloodPressure = [_patient] call EFUNC(circulation,getBloodPressure);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
private _map = GET_MAP(_unit);
private _hasLowBP = GVAR(Stable_TrackLowBP) && (_map < 60);
if(_hasLowBP) then {
	private _bp = [_patient, _isMedic] call FUNC(displayBP);
	private _name = format[[LOC(Stable,Low_Blood_Pressure)] call FUNC(cachedLocalisationCall), _bp];
	private _action = ["MIRA_LowBP", _name, QPATHTOF(ui\bp_low.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Unconscious Action
private _isUncon = GVAR(Unstable_TrackUnconscious) && (IS_UNCONSCIOUS(_patient));
if (_isUncon) then {
	private _action = ["MIRA_Sleepy", [LOC(Unstable,Unconscious)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\unconscious_white.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Unload Action
if(GVAR(Unstable_AllowUnload)) then {
	if (_isUncon || _isDead) then {
		private _confirmUnloadAction = { 
			params["_patient"];
			private _confirmUnload = [
				"MIRA_Unload_Confirm",
				[LOC(Shared,Confirm)] call FUNC(cachedLocalisationCall), 
				QPATHTOF(ui\unload.paa), 
				{
					params ["_patient", "_player", "_parameters"];
					[_patient, _player, true] call FUNC(unloadPatient);
				},
				{true},
				{},
				[]
			] call ace_interact_menu_fnc_createAction;
			[[_confirmUnload, [], _patient]]
		};

		private _action = ["MIRA_Unload", [LOC(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\unload.paa), {
				params ["_target", "_player", "_parameters"];
			}, {true}, _confirmUnloadAction] call ace_interact_menu_fnc_createAction;

		_actions pushBack [_action, [], _patient];
	};
};

// TODO: Add an action that shows if medication in system
_actions
