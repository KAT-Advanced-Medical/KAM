#include "..\script_component.hpp"
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
	[]
};

private _actions = [];

//conditions to display the unit's action
private _conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_patient"];
	if(!GVAR(Unstable_TrackDead) && !alive _patient) exitWith { false };
	[_patient] call FUNC(isUnstable);
};

//modify the icon to show the worst 'wound' type
private _modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	// Get vars to check
	private _bleeding = GVAR(Unstable_TrackBleeding) && [_patient] call FUNC(needsBandage);
	private _sleepy = GVAR(Unstable_TrackUnconscious) && (IS_UNCONSCIOUS(_patient));
	private _cardiac = GVAR(Unstable_TrackCardiacArrest) && (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] != 0);
	private _dead = GVAR(Unstable_TrackDead) && !alive _patient;
	private _kat_spO2Low = false;

	if(GVAR(EnableSupportKAT)) then {
		_kat_spO2Low = GVAR(Unstable_TrackSpO2) && (GET_KAT_SPO2(_player) < EGVAR(breathing,Stable_spo2));
	};

	// Modify the icon (3rd param)
	//Use ascending order of importance, cardiac > bleeding > unconscious > leg fracture
	private _result = "";
	if(_sleepy) then {
		_result = QPATHTOF(ui\unconscious_white.paa);
	};
	if(_bleeding) then {
		_result = QPATHTOF(ui\bleeding_red.paa);
	};
	if(_kat_spO2Low) then {
		_result = QPATHTOF(ui\kat_spo2_low.paa);
	};
	if(_cardiac) then {
		_result = QPATHTOF(ui\cardiac_arrest_red.paa);
	};
	if(_dead) then {
		_result = QPATHTOF(ui\dead.paa);
	};
	_actionData set [2, _result];
};

//foreach player/npc in vehicle
{
	private _unit = _x;
	//ignore drone pilot(s)
	if(getText (configOf _unit >> "simulation") != "UAVPilot") then {
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