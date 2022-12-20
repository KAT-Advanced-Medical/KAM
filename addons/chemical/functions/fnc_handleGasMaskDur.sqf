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

waitUntil{!isNil "kat_chemical_avail_gasmask" && player getVariable [QGVAR(enteredPoisen), false]};

[
	{
		params["_player"];
		!isNil "kat_chemical_avail_gasmask" && _player getVariable [QGVAR(enteredPoisen), false]
	},
	{
		params["_player"];
		if(_player getVariable [QGVAR(enteredPoisen), false] && goggles _player in KAT_AVAIL_GASMASK) then {
			private _timeEntered = CBA_missionTime;
			private _maxTime = missionNamespace getVariable[QGVAR(gasmask_durability),900];
			private _maxDura = 10;
			private _currentDura = _player getVariable[QGVAR(gasmask_durability),10];
			[{
				params["_param","_handler"];
				_param params["_player","_timeEntered","_maxTime","_maxDura","_currentDura"];
				private _currentDura = _player getVariable[QGVAR(gasmask_durability),10];

				if (_player getVariable [QGVAR(gasmask_durability_reset),false]) then {
					_player setVariable [QGVAR(gasmask_durability_reset),false,true];
					[_handler] call CBA_fnc_removePerFrameHandler;
					[] spawn FUNC(handleGasMaskDur);
				};

				private _timeLeft = _maxTime - (CBA_missionTime - _timeEntered);
				private _prozent = round((10/_maxTime)*_timeLeft);
				
				if(_currentDura != _prozent) then {
					_player setVariable[QGVAR(gasmask_durability),_prozent];
				};
		
				if(_currentDura <= 0 || _prozent <= 0 || !(alive _player)) exitWith {
					[_handler] call CBA_fnc_removePerFrameHandler;
					_player setVariable[QGVAR(gasmask_durability),0];
					[] spawn FUNC(handleGasMaskDur);
				};

				if !(_player getVariable [QGVAR(enteredPoisen), false]) exitWith{
					[_handler] call CBA_fnc_removePerFrameHandler;
					[] spawn FUNC(handleGasMaskDur);
				};

			},1,[_player,_timeEntered,_maxTime,_maxDura,_currentDura]] call CBA_fnc_addPerFrameHandler;
		} else {
			[
				{
					params["_player"];
					!(_player getVariable [QGVAR(enteredPoisen), false]) || goggles _player in KAT_AVAIL_GASMASK
				},
				{
					[] call FUNC(handleGasMaskDur);
				},
				[_player]
			] call CBA_fnc_waitUntilAndExecute;
		};
	},
	[player]
] call CBA_fnc_waitUntilAndExecute;