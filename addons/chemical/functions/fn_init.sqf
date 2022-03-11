#include "script_component.hpp"
///////////////////

///////////////////

//INIT Gasmasks

[] spawn {
	waitUntil {!isNil "kat_medical_avail_gasmask" && time > 1};
	private _items = missionNamespace getVariable ["kat_medical_avail_gasmask","""G_AirPurifyingRespirator_01_F"""];
	private _item_arr = [_items,"CfgGlasses"] call FUNC(getList);
	KAT_AVAIL_GASMASK = _item_arr;
	publicVariable "KAT_AVAIL_GASMASK";

	waitUntil {!isNil "kat_medical_affectAI"};
	private _affectAI = missionNamespace getVariable ["kat_medical_affectAI",false];
	kat_AFFECT_AI = _affectAI;
	publicVariable "kat_AFFECT_AI";
};



if(hasInterface) then {

	[] spawn FUNC(coughing);
	[] spawn FUNC(handlePoisenDamage);
	[] spawn FUNC(handleGasMaskDur);
	[] spawn FUNC(chemDetector);
	[player] spawn FUNC(breathing);
	kat_lastpoisend = 0;
	player addEventHandler ["killed", {call FUNC(handleRespawn)}];
	[] spawn {
		call FUNC(handleRespawn);
	};
	player setVariable["kat_gas_timeleft",missionNamespace getVariable ["kat_medical_infectTime",60],true];
	player setVariable ["kat_medical_enteredPoisen",false,true];
	player setVariable ["kat_gasmask_durability",10,true];
	player setVariable ["kat_gasmask_durability_reset", false, true];
	

	[{
		private _playertime = player getVariable["kat_gas_timeleft",60];
		private _maxtime = missionNamespace getVariable ["kat_medical_infectTime",60];
		if (!(player getVariable["kat_medical_enteredPoisen",false]) ) then {
			if(_playertime < missionNamespace getVariable ["kat_medical_infectTime",60]) then {
				_playertime = _playertime + 1;
				if(_playertime >= _maxtime) then {
					_playertime = _maxtime;
				};
				player setVariable["kat_gas_timeleft",_playertime,true];
			};
		};
	},2,[]]call CBA_fnc_addPerFrameHandler;

	[{
		"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
		private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
		private _obj = _ui displayCtrl 101;
		if (!(player getVariable["kat_medical_enteredPoisen",false]) ) then { 
			_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
		};
	},2,[]]call CBA_fnc_addPerFrameHandler;
};




