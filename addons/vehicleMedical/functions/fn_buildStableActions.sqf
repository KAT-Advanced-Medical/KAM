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
 * [_player,_target,[_patient]] call MIRA_fnc_buildStableActions
 *
 * Public: Yes
 */

params["_target", "_player", "_parameters"];

_parameters params [
	"_patient"
];

private _actions = [];
private _isMedic = _player call FUNC(isMedic);

// Bandagable Wounds Action
private _needsBandage = GVAR(Stable_TrackNeedsBandage) && _patient call FUNC(needsBandage);
if(_needsBandage) then {
	private _requiredBandages = [_patient] call FUNC(getNumberOfWoundsToBandage);
	LOGF_1("'%1' has unbandadged wounds", _patient);
	private _action = ["MIRA_Bandage", format[[LSTRING(Stable,Bandage)] call FUNC(cachedLocalisationCall), _requiredBandages] , QUOTE(ICON_PATH(bandage)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Stitchable Wounds Action
private _stitchWounds = _patient call FUNC(getStitchableWounds);
private _needsStitch = GVAR(Stable_TrackStitchableWounds) && count _stitchWounds > 0;
if (_needsStitch) then {
	LOGF_1("'%1' has stitchable wounds", _patient);
	private _action = ["MIRA_Stitch", format[[LSTRING(Stable,Stitch)] call FUNC(cachedLocalisationCall), count _stitchWounds] , QUOTE(ICON_PATH(stitch)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Heartrate Action
private _hasLowHR = GVAR(Stable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOGF_1("'%1' has low HR", _patient);
	private _hr = [_patient, _isMedic] call FUNC(displayHR);
	private _action = ["MIRA_LowHR", format[[LSTRING(Stable,Low_Heart_Rate)] call FUNC(cachedLocalisationCall), _hr], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Blood Pressure Action
private _hasLowBP = GVAR(Stable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOGF_1("'%1' has low BP", _patient);
	private _bp = [_patient, _isMedic] call FUNC(displayBP);
	private _name = format[[LSTRING(Stable,Low_Blood_Pressure)] call FUNC(cachedLocalisationCall), _bp];
	if(GVAR(Stable_TrackIV)) then {
		private _iv =  _patient call FUNC(getTotalIV);
		if(_iv > 0) then {
			_name = format[[LSTRING(Stable,Low_Blood_Pressure_With_IV)] call FUNC(cachedLocalisationCall), _bp, _iv];
		};
	};
	private _action = ["MIRA_LowBP", _name, QUOTE(ICON_PATH(bp_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Fractures
if(GVAR(Stable_TrackFractures) && [_patient] call FUNC(hasFractures)) then {
	LOGF_1("'%1' has fractures", _patient);
	private _numFractures = [_patient] call FUNC(getNumberOfFractures);
	private _fracturesMessage =  format[[LSTRING(Stable,Arm_Fractures)] call FUNC(cachedLocalisationCall), _numFractures];
	if(_numFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = [LSTRING(Stable,Arm_Fractures_Error)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Fractures", _fracturesMessage, QUOTE(ICON_PATH(fracture)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};


// Splinted Fractures
if(GVAR(Stable_TrackSplints) && [_patient, true] call FUNC(hasFractures)) then {
	LOGF_1("'%1' has splinted fractures", _patient);
	private _numFractures = [_patient, true] call FUNC(getNumberOfFractures);
	private _fracturesMessage =  format[[LSTRING(Stable,Splinted_Fractures)] call FUNC(cachedLocalisationCall), _numFractures];
	if(_numFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = [LSTRING(Stable,Splinted_Fractures_Error)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Splinted_Fractures", _fracturesMessage, QUOTE(ICON_PATH(splint)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Tourniquets
private _tourniquets = GVAR(Stable_TrackTourniquets) && [_patient] call FUNC(hasTourniquets);
if(_tourniquets) then {
	LOGF_1("'%1' has tourniquets", _tourniquets);
	private _amount = [_patient] call FUNC(getNumberOfTourniquets);
	private _action = ["MIRA_Tourniquets", format[[LSTRING(Stable,Tourniquets)] call FUNC(cachedLocalisationCall), _amount], QUOTE(ICON_PATH(tourniquet)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

_actions