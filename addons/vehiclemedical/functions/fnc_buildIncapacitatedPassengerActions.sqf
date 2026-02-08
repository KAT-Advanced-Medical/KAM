#include "..\script_component.hpp"

params["_vehicle", "_player"];

if!(alive _vehicle) exitWith { 
	[]
};

private _modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	
};

private _actions = [];

// Unload All Children
private _fnc_forceUnloadAllAction = { 
	params["_patient"];
	private _forceUnload = [
		"MIRA_UnloadAll_Force",
		[LOC(Incapacitated,Unload_Force)] call FUNC(cachedLocalisationCall), 
		QPATHTOF(ui\unload.paa), 
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
	[LOC(Incapacitated,Unload_All)] call FUNC(cachedLocalisationCall), 
	QPATHTOF(ui\unload.paa), 
	{
		params ["_vehicle", "_player", "_parameters"];
		[_vehicle, _player, {
			params["_patient"];
			_patient != player && ((IS_UNCONSCIOUS(_patient)) || !(alive _patient))
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
	if(getText (configOf _unit >> "simulation") != "UAVPilot") then {
		//get unit name from ace common to display
		private _unitName = [_unit] call ace_common_fnc_getName;
		//icon is blank, defined by modififer func
		private _icon = "";

		private _fnc_conditions = {
			params["_patient", "_player", "_parameters"];
			!(alive _patient) || (IS_UNCONSCIOUS(_patient))
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
					private _isMedic = (_player call ACEFUNC(medical_treatment,isMedic));

					if (((IS_UNCONSCIOUS(_patient)) || !alive _patient) && _isMedic) then {
						
						private _forceUnloadAction = { 
							params["_patient"];
							private _forceUnload = [
								"MIRA_Unload_Force",
								[LOC(Incapacitated,Unload_Force)] call FUNC(cachedLocalisationCall), 
								QPATHTOF(ui\unload.paa), 
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

						private _action = ["MIRA_Unload", [LOC(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), QPATHTOF(ui\unload.paa), {
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