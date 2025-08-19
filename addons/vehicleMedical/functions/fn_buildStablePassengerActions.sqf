#include "function_macros.hpp"
/*
 * Author: esteldunedain, with minor changes by M3ales
 * Builds an array of actions, one for each passenger, with their name as the display.
 * Essentially a copy of https://github.com/acemod/ACE3/blob/e78016d7f7e193691f92bac10c3e437d64a4bfd0/addons/interaction/functions/fnc_addPassengersActions.sqf
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [vehicle player, player] call MIRA_Vehicle_Medical_fnc_buildUnstablePassengerActions
 *
 * Public: Yes
 */

params["_vehicle", "_player"];

if!(alive _vehicle) exitWith { 
	LOGF_1("%1 not alive, exiting.", _vehicle);
	[]
};

_actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	if(!alive _patient) exitWith { false };
	_unit call FUNC(isStable);
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	
	private _result = "";
	// bandage > stitch  > lowhr > lowbp > fractures > tourniquets
	private _tourniquet = GVAR(Stable_TrackTourniquets) && [_patient] call FUNC(hasTourniquets);
	private _fractures = GVAR(Stable_TrackFractures) && [_patient] call FUNC(hasFractures);
	private _isMedic = _player call FUNC(isMedic);
	private _lowBP = GVAR(Stable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
	private _lowHR = GVAR(Stable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
	private _stitch = GVAR(Stable_TrackStitchableWounds) && count ([_patient] call FUNC(getStitchableWounds)) > 0;
	private _bandage = GVAR(Stable_TrackNeedsBandage) && [_patient] call FUNC(needsBandage);

	if(_tourniquet) then {
		_result = QUOTE(ICON_PATH(tourniquet));
	};
	if(_fractures) then {
		_result = QUOTE(ICON_PATH(fracture));
	};
	if(_lowBP) then {
		_result = QUOTE(ICON_PATH(bp_low));
	};
	if(_lowHR) then {
		_result = QUOTE(ICON_PATH(hr_low));
	};
	if(_stitch) then {
		_result = QUOTE(ICON_PATH(stitch));
	};
	if(_bandage) then {
		_result = QUOTE(ICON_PATH(bandage));
	};

	if(_result == "") then {
		private _set = format["Tourniquet: %1, Fractures: %2, Low BP: %3, Low HR: %4, Stitch: %5, Bandage: %6, isMedic: %7",_tourniquet,_fractures,_lowBP,_lowHR,_stitch,_bandage,_isMedic];
		LOG_ERRORF_1("Couldnt find matching icon for stable given set: %1",_set);
	};
	_actionData set [2, _result];
};

 //foreach player/npc in vehicle
{
	private _unit = _x;
	//ignore drone pilot(s)
	if(getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot") then {
		//get unit name from ace common to display
		private _unitName = [_unit] call ace_common_fnc_getName;
		//icon is blank, defined by modififer func
		private _icon = "";
		//build the action, use additional params to have runOnHover = true
		if(_unit == _player) then {
			_unitName = "You";
		};
		private _action = [
			format["%1", _unit],
			_unitName,
			_icon,
			{
				params ["", "", "_parameters"];
				_parameters params ["_unit"];
				[_unit] call FUNC(openMedicalMenu);
			},
			_conditions,
			{
				//when creating children, only create children of unit who is being hovered over, otherwise empty children
				//probably performance thing, unsure
				if(ace_interact_menu_selectedTarget isEqualTo _target) then {
					_this call FUNC(buildStableActions);
				}else {
					[]
				};
			},
			[_unit],
			{[0, 0, 0]},
			2,
			[false, false, false, false, false],
			_modifierFunc
		] call ace_interact_menu_fnc_createAction;
		//add built action to array
		_actions pushBack[_action, [], _unit];
	};
	//I think this basically functions as a continue, not really sure.
	false
}count crew _vehicle;

_actions