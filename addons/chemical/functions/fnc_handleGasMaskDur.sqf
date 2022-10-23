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
 * [] call kat_chemical_fnc_handleGasMAskDur;
 *
 * Public: No
*/
uiSleep 5;
waitUntil{!isNil "kat_chemical_avail_gasmask" && player getVariable ["kat_medical_enteredPoisen", false]};

if(player getVariable ["kat_medical_enteredPoisen", false] && goggles player in KAT_AVAIL_GASMASK) then {
	private _timeEntered = CBA_missionTime;
	private _maxTime = missionNamespace getVariable["kat_medical_gasmask_durability",900];
	private _maxDura = 10;
	private _currentDura = player getVariable["kat_gasmask_durability",10];
	[{
		params["_param","_handler"];
		_param params["_player","_timeEntered","_maxTime","_maxDura","_currentDura"];
		private _currentDura = player getVariable["kat_gasmask_durability",10];

		if (player getVariable ["kat_gasmask_durability_reset",false]) then {
			player setVariable ["kat_gasmask_durability_reset",false,true];
			[_handler] call CBA_fnc_removePerFrameHandler;
			[] spawn FUNC(handleGasMaskDur);
		};

		private _timeLeft = _maxTime - (CBA_missionTime - _timeEntered);
		private _prozent = round((10/_maxTime)*_timeLeft);
		
		if(_currentDura != _prozent) then {
			player setVariable["kat_gasmask_durability",_prozent];
		};
 
		if(_currentDura <= 0 || _prozent <= 0 || !(alive _player)) exitWith {
			[_handler] call CBA_fnc_removePerFrameHandler;
			player setVariable["kat_gasmask_durability",0];
			[] spawn FUNC(handleGasMaskDur);
		};

		if !(player getVariable ["kat_medical_enteredPoisen", false]) exitWith{
			[_handler] call CBA_fnc_removePerFrameHandler;
			[] spawn FUNC(handleGasMaskDur);
		};

	},1,[player,_timeEntered,_maxTime,_maxDura,_currentDura]] call CBA_fnc_addPerFrameHandler;
} else {
	waitUntil{!(player getVariable ["kat_medical_enteredPoisen", false]) || goggles player in KAT_AVAIL_GASMASK};
	[] spawn FUNC(handleGasMaskDur);
}

