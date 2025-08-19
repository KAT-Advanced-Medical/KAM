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

private _actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_patient"];
	if(!GVAR(Unstable_TrackDead) && !alive _patient) exitWith { false };
	[_patient] call FUNC(isUnstable);
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	// Get vars to check
	private _bleeding = GVAR(Unstable_TrackBleeding) && [_patient] call FUNC(isBleeding);
	private _sleepy = GVAR(Unstable_TrackUnconscious) && [_patient] call FUNC(isUnconscious);
	private _cardiac = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
	private _legFractures = GVAR(Unstable_TrackLegFractures) && [_patient] call FUNC(hasLegFractures);
	private _dead = GVAR(Unstable_TrackDead) && !alive _patient;
	//KAT Priority
	private _kat_pneumothorax = false;
	private _kat_airwayBlocked = false;
	private _kat_spO2Low = false;

	if(GVAR(EnableSupportKAT)) then {
		_kat_pneumothorax = GVAR(Unstable_TrackAllPneumothorax) &&
		([_patient] call FUNC(kat_getPneumothorax) 
			|| [_patient] call FUNC(kat_getTensionPneumothorax) 
			|| [_patient] call FUNC(kat_getHemopneumothorax));
		_kat_airwayBlocked = GVAR(Unstable_TrackAirwayBlocked) && ([_patient] call FUNC(kat_getAirwayObstruction) || [_patient] call FUNC(kat_getAirwayOcclusion));
		_kat_spO2Low = GVAR(Unstable_TrackSpO2) && ([_patient] call FUNC(kat_getAirwayStatus) < 85);
	};

	// Modify the icon (3rd param)
	//Use ascending order of importance, cardiac > bleeding > unconscious > leg fracture
	private _result = "";
	if(_legFractures) then {
		_result = QUOTE(ICON_PATH(fracture));
	};
	if(_sleepy) then {
		_result = QUOTE(ICON_PATH(unconscious_white));
	};
	if(_kat_pneumothorax) then {
		_result = QUOTE(ICON_PATH(kat_pneumothorax));
	};
	if(_kat_airwayBlocked) then {
		_result = QUOTE(ICON_PATH(kat_airway_blocked));
	};
	if(_bleeding) then {
		_result = QUOTE(ICON_PATH(bleeding_red));
	};
	if(_kat_spO2Low) then {
		_result = QUOTE(ICON_PATH(kat_spo2_low));
	};
	if(_cardiac) then {
		_result = QUOTE(ICON_PATH(cardiac_arrest_red));
	};
	if(_dead) then {
		_result = QUOTE(ICON_PATH(dead));
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
		if(_unit == _player) then {
			_unitName = "You";
		};
		//build the action, use additional params to have runOnHover = true
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
					_this call FUNC(buildUnstableActions);
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