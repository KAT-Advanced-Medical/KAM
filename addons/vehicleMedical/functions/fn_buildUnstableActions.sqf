#include "function_macros.hpp"
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
private _isMedic = _player call FUNC(isMedic);

// Dead
private _isDead = GVAR(Unstable_TrackDead) && !alive _patient;
if(_isDead) then {
	LOGF_1("'%1' is dead", _patient);
	private _action = ["MIRA_Dead", [LSTRING(Unstable,Dead)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(dead)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
			if(GVAR(WarnViewingDead)) then {
				private _patientName = [_patient] call ace_common_fnc_getName;
				[format[[LSTRING(Unstable,Dead_Warning)] call FUNC(cachedLocalisationCall), _patientName], true, 4, 1] call ACE_common_fnc_displayText;
			};
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

private _canTakeDogtag = GVAR(Unstable_TakeDogtags) && [_player, _patient] call ace_dogtags_fnc_canTakeDogtag;
// Take Dogtags Action
if(_canTakeDogtag && {(GVAR(Unstable_DogtagsDeadOnly) && !alive _patient) || !GVAR(Unstable_DogtagsDeadOnly)}) then {
	private _taken = [LSTRING(Unstable,Dogtags_Take)] call FUNC(cachedLocalisationCall);
	if(_patient getVariable["ace_dogtags_dogtagTaken", objNull] == _target) then {
		_taken =  [LSTRING(Unstable,Dogtags_Already_Taken)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Dogtags_Take", _taken, QUOTE(ICON_PATH(dogtags)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_player, _patient] call ace_dogtags_fnc_takeDogtag;
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Cardiac Arrest Action
private _cardiacArrest = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
if (_cardiacArrest) then {
	LOGF_1("'%1' is in Cardiac Arrest", _patient);
	_action = ["MIRA_Cardiac", [LSTRING(Unstable,Cardiac_Arrest)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(cardiac_arrest_red)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// KAT Integration Actions
if(GVAR(EnableSupportKAT)) then {
	private _spO2 = [_patient] call FUNC(kat_getAirwayStatus);
	if(GVAR(Unstable_TrackSpO2) && _spO2 < 85) then {
		_action = ["MIRA_KAT_SpO2", format[[LSTRING(Unstable_KAT,SpO2)] call FUNC(cachedLocalisationCall), round _spO2, "%"], QUOTE(ICON_PATH(kat_spO2_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
	};
	private _pneumothorax = [_patient] call FUNC(kat_getPneumothorax);
	private _hemopneumothorax = [_patient] call FUNC(kat_getHemopneumothorax);
	private _tensionPneumothorax = [_patient] call FUNC(kat_getTensionPneumothorax);
	private _pneumothoraces = [_pneumothorax, _hemopneumothorax, _tensionPneumothorax];
	if(GVAR(Unstable_TrackAllPneumothorax) && (_pneumothorax || _hemopneumothorax || _tensionPneumothorax)) then {
		private _name = [LSTRING(Unstable_KAT,Pneumothorax)] call FUNC(cachedLocalisationCall);
		if({ _x == true } count _pneumothoraces == 1) then {
			if(_hemopneumothorax) then {
				_name =  [LSTRING(Unstable_KAT,Hemopneumothorax)] call FUNC(cachedLocalisationCall);
			};
			if(_tensionPneumothorax) then {
				_name = [LSTRING(Unstable_KAT,Tension_Pneumothorax)] call FUNC(cachedLocalisationCall);
			};
		}
		else
		{
			_name = [LSTRING(Unstable_KAT,Multiple_Pneumothorax)] call FUNC(cachedLocalisationCall);
		};

		_action = ["MIRA_KAT_Pneumothorax", _name, QUOTE(ICON_PATH(kat_pneumothorax)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _patient];
	};
	private _airwayObstruction = [_patient] call FUNC(kat_getAirwayObstruction);
	private _airWayOcclusion = [_patient] call FUNC(kat_getAirwayOcclusion);
	if(GVAR(Unstable_TrackAirwayBlocked) && (_airwayObstruction || _airWayOcclusion)) then {
		private _name = [LSTRING(Unstable_KAT,Airway_Obstructed)] call FUNC(cachedLocalisationCall);
		if(_airwayObstruction) then {
			_name = [LSTRING(Unstable_KAT,Airway_Occluded)] call FUNC(cachedLocalisationCall);
			if(_airWayOcclusion) then {
				_name = [LSTRING(Unstable_KAT,Airway_Blocked)] call FUNC(cachedLocalisationCall);
			};
		};
		_action = ["MIRA_KAT_AirwayBlocked", _name, QUOTE(ICON_PATH(kat_airway_blocked)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _patient];
	};
};

// Bleeding Action
private _isBleeding = GVAR(Unstable_TrackBleeding) && _patient call FUNC(isBleeding);
//add bleeding action if applicable
if (_isBleeding) then {
	//TODO: collect all wounds, and colour icon based on severity, only have red done for now
	_icon = [
		QUOTE(ICON_PATH(bleeding_red)),
		QUOTE(ICON_PATH(bleeding_yellow)),
		QUOTE(ICON_PATH(bleeding_white))
	] select 0;
	LOGF_1("'%1' is Bleeding", _patient);
	_action = ["MIRA_Bleeding", [LSTRING(Unstable,Bleeding)] call FUNC(cachedLocalisationCall), _icon, {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low HeartRate Action
private _hasLowHR = GVAR(Unstable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOGF_1("'%1' has low HR", _patient);
	private _hr = [_patient, _isMedic] call FUNC(displayHR);
	private _action = ["MIRA_LowHR", format[[LSTRING(Unstable,Low_Heart_Rate)] call FUNC(cachedLocalisationCall), _hr], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Blood Pressure Action
private _hasLowBP = GVAR(Unstable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOGF_1("'%1' has low BP", _patient);
	private _bp = [_patient, _isMedic] call FUNC(displayBP);
	private _name = format[[LSTRING(Unstable,Low_Blood_Pressure)] call FUNC(cachedLocalisationCall), _bp];
	if(GVAR(Unstable_TrackIV)) then {
		private _iv =  _patient call FUNC(getTotalIV);
		if(_iv > 0) then {
			_name = format[[LSTRING(Unstable,Low_Blood_Pressure_With_IV)] call FUNC(cachedLocalisationCall), _bp, _iv];
		};
	};
	private _action = ["MIRA_LowBP", _name, QUOTE(ICON_PATH(bp_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Unconscious Action
private _isUncon = GVAR(Unstable_TrackUnconscious) && [_patient] call FUNC(isUnconscious);
if (_isUncon) then {
	LOGF_1("'%1' is Unconscious", _patient);
	private _action = ["MIRA_Sleepy", [LSTRING(Unstable,Unconscious)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(unconscious_white)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Fractures (Legs)
if(GVAR(Unstable_TrackLegFractures) && [_patient] call FUNC(hasLegFractures)) then {
	LOGF_1("'%1' has leg fractures", _patient);
	private _numLegFractures = [_patient] call FUNC(getNumberOfLegFractures);
	private _fracturesMessage =  format[[LSTRING(Unstable,Leg_Fractures)] call FUNC(cachedLocalisationCall), _numLegFractures];
	if(_numLegFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = "Leg Fractures (Error Fetching Amount)"
	};
	private _action = ["MIRA_Fractures", _fracturesMessage, QUOTE(ICON_PATH(fracture)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Splinted Fractures (Legs)
if(GVAR(Unstable_TrackLegSplints) && [_patient, true] call FUNC(hasLegFractures)) then {
	LOGF_1("'%1' has splinted leg fractures", _patient);
	private _numLegFractures = [_patient, true] call FUNC(getNumberOfLegFractures);
	private _fracturesMessage =  format[[LSTRING(Unstable,Splinted_Leg_Fractures)] call FUNC(cachedLocalisationCall), _numLegFractures];
	if(_numLegFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = [LSTRING(Unstable,Splinted_Leg_Fractures_Error)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Splinted_Fractures", _fracturesMessage, QUOTE(ICON_PATH(splint)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Unload Action
if(GVAR(Unstable_AllowUnload)) then {
	if (_isUncon || _isDead) then {
		LOGF_1("'%1' is unloadable", _patient);

		private _confirmUnloadAction = { 
			params["_patient"];
			private _confirmUnload = [
				"MIRA_Unload_Confirm",
				[LSTRING(Shared,Confirm)] call FUNC(cachedLocalisationCall), 
				QUOTE(ICON_PATH(unload)), 
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

		private _action = ["MIRA_Unload", [LSTRING(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(unload)), {
				params ["_target", "_player", "_parameters"];
			}, {true}, _confirmUnloadAction] call ace_interact_menu_fnc_createAction;

		_actions pushBack [_action, [], _patient];
	};
};

// TODO: Add an action that shows if medication in system
_actions
