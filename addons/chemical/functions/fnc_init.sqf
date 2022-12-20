#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: 
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_init;
 *
 * Public: No
*/

[] spawn {
	waitUntil {!isNil "kat_chemical_avail_gasmask" && time > 1};
	private _items = missionNamespace getVariable ["kat_chemical_avail_gasmask","""G_AirPurifyingRespirator_01_F"""];
	private _item_arr = [_items,"CfgGlasses"] call FUNC(getList);
	KAT_AVAIL_GASMASK = _item_arr;
	publicVariable "KAT_AVAIL_GASMASK";

	waitUntil {!isNil "kat_medical_affectAI"};
	private _affectAI = missionNamespace getVariable ["kat_medical_affectAI",false];
	kat_AFFECT_AI = _affectAI;
	publicVariable "kat_AFFECT_AI";
};



if(hasInterface) then {

	[] call FUNC(coughing);
	[] spawn FUNC(handleGasMaskDur);
	[] spawn FUNC(chemDetector);
	[player] spawn FUNC(breathing);
	kat_lastpoisend = 0;
	player setVariable[QGVAR(timeleft),missionNamespace getVariable [QGVAR(infectTime),60],true];
	player setVariable [QGVAR(enteredPoisen),false,true];
	player setVariable [QGVAR(gasmask_durability),10,true];
	player setVariable [QGVAR(gasmask_durability_reset), false, true];
	

	[{
		private _playertime = player getVariable[QGVAR(timeleft),60];
		private _maxtime = missionNamespace getVariable [QGVAR(infectTime),60];
		if (!(player getVariable[QGVAR(enteredPoisen),false]) ) then {
			if(_playertime < missionNamespace getVariable [QGVAR(infectTime),60]) then {
				_playertime = _playertime + 1;
				if(_playertime >= _maxtime) then {
					_playertime = _maxtime;
				};
				player setVariable[QGVAR(timeleft),_playertime,true];
			};
		};
	},2,[]]call CBA_fnc_addPerFrameHandler;

	[{
		"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
		private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
		private _obj = _ui displayCtrl 101;
		if (!(player getVariable[QGVAR(enteredPoisen),false]) ) then { 
			_obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
		};
	},2,[]]call CBA_fnc_addPerFrameHandler;
};




