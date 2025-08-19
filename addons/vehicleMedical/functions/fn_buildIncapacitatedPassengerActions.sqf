#include "function_macros.hpp"

params["_vehicle", "_player"];

if!(alive _vehicle) exitWith { 
	LOGF_1("%1 not alive, exiting.", _vehicle);
	[]
};

_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	
};

private _actions = [];

// Unload All Children
private _fnc_forceUnloadAllAction = { 
	params["_patient"];
	private _forceUnload = [
		"MIRA_UnloadAll_Force",
		[LSTRING(Incapacitated,Unload_Force)] call FUNC(cachedLocalisationCall), 
		QUOTE(ICON_PATH(unload)), 
		{
			params ["_vehicle", "_player", "_parameters"];
			[_vehicle, _player, {true}, true] call FUNC(unloadAllWithCondition);
		},
		{true},
		{},
		[]
	] call ace_interact_menu_fnc_createAction;
	[[_forceUnload, [], _patient]]
};

// Unload All Action
private _unloadAllAction = ["MIRA_UnloadAll", 
	[LSTRING(Incapacitated,Unload_All)] call FUNC(cachedLocalisationCall), 
	QUOTE(ICON_PATH(unload)), 
	{
		params ["_vehicle", "_player", "_parameters"];
		[_vehicle, _player, {
			params["_patient"];
			_patient != player && ([_patient] call FUNC(isUnconscious) || !(alive _patient))
		}] call FUNC(unloadAllWithCondition);
	},
	{true},
	_fnc_forceUnloadAllAction,
	[]
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_unloadAllAction, [], _vehicle];

 //foreach player/npc in vehicle
{
	private _unit = _x;
	//ignore drone pilot(s)
	if(getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot") then {
		//get unit name from ace common to display
		private _unitName = [_unit] call ace_common_fnc_getName;
		//icon is blank, defined by modififer func
		private _icon = "";

		private _fnc_conditions = {
			params["_patient", "_player", "_parameters"];
			!(alive _patient) || _patient call FUNC(isUnconscious)
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
			_fnc_conditions,
			{
				params["_patient", "_player", "_parameters"];

				//when creating children, only create children of unit who is being hovered over, otherwise empty children
				//probably performance thing, unsure
				if(ace_interact_menu_selectedTarget isEqualTo _patient) then {
					private _subActions = [];
					private _isMedic = _player call FUNC(isMedic);

					if([_patient] call FUNC(isUnconscious) || !alive _patient) then {
						
						private _forceUnloadAction = { 
							params["_patient"];
							private _forceUnload = [
								"MIRA_Unload_Force",
								[LSTRING(Incapacitated,Unload_Force)] call FUNC(cachedLocalisationCall), 
								QUOTE(ICON_PATH(unload)), 
								{
									params ["_patient", "_player", "_parameters"];
									[_patient, _player, true] call FUNC(unloadPatient)
								},
								{true},
								{},
								[]
							] call ace_interact_menu_fnc_createAction;
							[[_forceUnload, [], _patient]]
						};

						private _action = ["MIRA_Unload", [LSTRING(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(unload)), {
								params ["_target", "_player", "_parameters"];
								[_target, _player] call FUNC(unloadPatient);
							}, {true}, _forceUnloadAction] call ace_interact_menu_fnc_createAction;
						
						_subActions pushBack [_action, [], _patient];
					};

					_subActions
				}else {
					[]
				};
			},
			[],
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