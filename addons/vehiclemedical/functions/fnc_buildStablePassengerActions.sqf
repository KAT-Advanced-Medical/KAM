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

_actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	if(!alive _unit) exitWith { false };
	_unit call FUNC(isStable);
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	
	private _result = "";
	// bandage > stitch  > lowhr > lowbp > fractures > tourniquets
	private _tourniquet = GVAR(Stable_TrackTourniquets) && ((selectMax GET_TOURNIQUETS(_patient)) > 0);
	private _fractures = GVAR(Stable_TrackFractures) && ((selectMax GET_FRACTURES(_patient)) > 0);
	private _isMedic = (_player call ACEFUNC(medical_treatment,isMedic));
	private _bloodPressure = [_patient] call EFUNC(circulation,getBloodPressure);
	_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
	private _map = GET_MAP(_unit);
	private _lowBP = GVAR(Stable_TrackLowBP) && (_map < 60);
	private _lowHR = GVAR(Stable_TrackLowHR) && (GET_HEART_RATE(_patient) < 60);
	private _stitchWounds = _patient call EFUNC(misc,getFullBodyStitchableWoundTime);
	private _stitch = (_stitchWounds > 0);
	private _bandage = GVAR(Stable_TrackNeedsBandage) && [_patient] call FUNC(needsBandage);

	if(_tourniquet) then {
		_result = QPATHTOF(ui\tourniquet.paa);
	};
	if(_fractures) then {
		_result = QPATHTOF(ui\fracture.paa);
	};
	if(_lowBP) then {
		_result = QPATHTOF(ui\bp_low.paa);
	};
	if(_lowHR) then {
		_result = QPATHTOF(ui\hr_low.paa);
	};
	if(_stitch) then {
		_result = QPATHTOF(ui\stitch.paa);
	};
	if(_bandage) then {
		_result = QPATHTOF(ui\bandage.paa);
	};

	if(_result == "") then {
		private _set = format["Tourniquet: %1, Fractures: %2, Low BP: %3, Low HR: %4, Stitch: %5, Bandage: %6, isMedic: %7",_tourniquet,_fractures,_lowBP,_lowHR,_stitch,_bandage,_isMedic];
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