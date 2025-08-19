#include "functions\function_macros.hpp"
["ace_interact_menu_newControllableObject", {
    params ["_type"]; // string of the object's classname
	private _validTypes = [];

	if(GVAR(Vehicles_EnableHelicopter)) then {
		_validTypes pushBackUnique "Helicopter";
	};
	if(GVAR(Vehicles_EnableCar)) then {
		_validTypes pushBackUnique "Car";
	};
	if(GVAR(Vehicles_EnableTank)) then {
		_validTypes pushBackUnique "Tank";
	};
	if(GVAR(Vehicles_EnablePlane)) then {
		_validTypes pushBackUnique "Plane";
	};
	if(GVAR(Vehicles_EnableShip)) then {
		_validTypes pushBackUnique "Ship";
	};

    if (_validTypes findIf { _type isKindOf (_x) } == -1) exitWith {};    
    private _action = 
		[
			"MIRA_Medical",
			[LSTRING(Interaction,Medical)] call FUNC(cachedLocalisationCall),
			"",
			{ if(true) exitWith{} },
			{ GVAR(EnableAVM) }
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Stable",
			[LSTRING(Interaction,Stable)] call FUNC(cachedLocalisationCall),
			"",
			{ },
			{ 
				params["_vehicle"];
				private _count = [_vehicle] call FUNC(countStable);
				GVAR(EnableStable) && _count > 0
			},
			{ [QUOTE(GVAR(StableCache)),_this, FUNC(buildStablePassengerActions)] call FUNC(cachedResult) },
			[],
			[0,0,0],
			10,
			nil,
			{
				params ["_target", "_player", "_params", "_actionData"];
				if(!GVAR(Stable_ShowCount)) exitWith {};
				private _name = _actionData select 1;
				_name = format[_name + " (%1)", [_target] call FUNC(countStable)];
				_actionData set [1, _name];
			}
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Unstable",
			[LSTRING(Interaction,Unstable)] call FUNC(cachedLocalisationCall),
			"",
			{ }, 
			{ 
				params["_vehicle"];
				private _count = [_vehicle] call FUNC(countUnstable);
				GVAR(EnableUnstable) && _count > 0 
			},
			{ [QUOTE(GVAR(UnstableCache)), _this, FUNC(buildUnstablePassengerActions)] call FUNC(cachedResult) },
			[],
			[0,0,0],
			10,
			nil,
			{
				params ["_target", "_player", "_params", "_actionData"];
				if(!GVAR(Unstable_ShowCount)) exitWith {};
				private _name = _actionData select 1;
				_name = format[_name + " (%1)", [_target] call FUNC(countUnstable)];
				_actionData set [1, _name];
			}
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Incapacitated",
			[LSTRING(Interaction,Incapacitated)] call FUNC(cachedLocalisationCall),
			"",
			{ }, 
			{ 
				params["_vehicle"];
				private _count = [_vehicle] call FUNC(countIncapacitated);
				GVAR(EnableIncapacitated) && _count > 0
			},
			{ [QUOTE(GVAR(IncapacitatedCache)), _this, FUNC(buildIncapacitatedPassengerActions)] call FUNC(cachedResult) },
			[],
			[0,0,0],
			10,
			nil,
			{
				params ["_target", "_player", "_params", "_actionData"];
				if(!GVAR(Incapacitated_ShowCount)) exitWith {};
				private _name = _actionData select 1;
				_name = format[_name + " (%1)", [_target] call FUNC(countIncapacitated)];
				_actionData set [1, _name];
			}
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	LOGF_1("Dynamically added interaction to %1", _type);
}] call CBA_fnc_addEventHandler;

[QUOTE(GVAR(UnloadPatientForce)), { _this call FUNC(unloadPatientForceHandler) }] call cba_fnc_addEventHandler;