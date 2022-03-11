///////////////////

//////////////////
params["_object"];

private _action = [
	"kat_gas_interaction",
	LLSTRING(sealLeak),
	"",
	{
		params["_target", "_player"];
		
		[_player, "Acts_carFixingWheel"] call ACE_common_fnc_doAnimation;

		//add time to addon options
		[
			20,
			[_target,_player],
			{
				params["_args"];
				_args params ["_target","_player"];
				_target setVariable ["kat_gas_active", false,true];
				[_target, 0, ["ACE_MainActions", "kat_gas_interaction"]] call ace_interact_menu_fnc_removeActionFromObject;
				[_player, "kat_sealant"] call ace_common_fnc_useItem;
			},
			{
				params["_args"];
				_args params ["_target","_player"];
				[_player, "",1] call ACE_common_fnc_doAnimation;
			},
			LLSTRING(GasModule_SealLeak),
			{[_player,_player,["kat_sealant"]] call ace_medical_treatment_fnc_hasItem;},//conditions
			["isNotInside"]
		] call ace_common_fnc_progressBar;
	},
	{
		params["_target","_player"];

		[_player, _target] call ACE_common_fnc_canInteractWith;
		[_player,_player,["kat_sealant"]] call ace_medical_treatment_fnc_hasItem;

	},
	{},
	[]
] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;
