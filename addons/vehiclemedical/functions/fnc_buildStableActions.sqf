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
 * [_player,_target,[_patient]] call MIRA_fnc_buildStableActions
 *
 * Public: Yes
 */

params["_target", "_player", "_parameters"];

_parameters params [
	"_patient"
];

private _actions = [];
private _isMedic = (_player call ACEFUNC(medical_treatment,isMedic));

// Bandagable Wounds Action
private _needsBandage = GVAR(Stable_TrackNeedsBandage) && _patient call FUNC(needsBandage);
if(_needsBandage) then {
	private _requiredBandages = [_patient] call FUNC(getNumberOfWoundsToBandage);
	private _action = ["MIRA_Bandage", format[[LOC(Stable,Bandage)] call FUNC(cachedLocalisationCall), _requiredBandages] , QPATHTOF(ui\bandage.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Stitchable Wounds Action
private _stitchWounds = _patient call EFUNC(misc,getFullBodyStitchableWoundTime);
private _needsStitch = (_stitchWounds > 0);
if (_needsStitch) then {
	private _action = ["MIRA_Stitch", format[[LOC(Stable,Stitch)] call FUNC(cachedLocalisationCall), _stitchWounds] , QPATHTOF(ui\stitch.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Heartrate Action
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

// Fractures
if(GVAR(Stable_TrackFractures) && ((selectMax GET_FRACTURES(_patient)) > 0)) then {
	private _numFractures = { _x != 0 } count GET_FRACTURES(_patient);
	private _fracturesMessage =  format[[LOC(Stable,Arm_Fractures)] call FUNC(cachedLocalisationCall), _numFractures];
	if(_numFractures == 0) then {
		_fracturesMessage = [LOC(Stable,Arm_Fractures_Error)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Fractures", _fracturesMessage, QPATHTOF(ui\fracture.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};


// Splinted Fractures
if(GVAR(Stable_TrackSplints) && (({ _x in [-1, -2, -3] } count (GET_FRACTURES(_patient))) > 0)) then {
	private _numFractures = { _x in [-1, -2, -3] } count (GET_FRACTURES(_patient));
	private _fracturesMessage =  format[[LOC(Stable,Splinted_Fractures)] call FUNC(cachedLocalisationCall), _numFractures];
	if(_numFractures == 0) then {
		_fracturesMessage = [LOC(Stable,Splinted_Fractures_Error)] call FUNC(cachedLocalisationCall);
	};
	private _action = ["MIRA_Splinted_Fractures", _fracturesMessage, QPATHTOF(ui\splint.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Tourniquets
private _tourniquets = GVAR(Stable_TrackTourniquets) && ((selectMax GET_TOURNIQUETS(_patient)) > 0);
if(_tourniquets) then {
	private _amount = { _x != 0 } count GET_TOURNIQUETS(_patient);
	private _action = ["MIRA_Tourniquets", format[[LOC(Stable,Tourniquets)] call FUNC(cachedLocalisationCall), _amount], QPATHTOF(ui\tourniquet.paa), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

_actions