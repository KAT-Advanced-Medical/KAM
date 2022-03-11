#include "script_component.hpp"

//////////////////////

//////////////////////
params ["_player"];
uiSleep 5;

waitUntil {goggles _player in KAT_AVAIL_GASMASK};

[
	{
		params["_args","_handler"];
		_args params ["_player"];
		if !(goggles _player in KAT_AVAIL_GASMASK || !(alive player) || _player getVariable["ace_medical_heartrate",80] <= 0) then {
			[_handler] call CBA_fnc_removePerFrameHandler;
			[_player] spawn FUNC(breathing);
 		} else {
			if(GET_PAIN_PERCEIVED(_player) >= 0.4 || _player getVariable["ace_medical_heartrate",80] >= 105) then {
				_player say3D "mask_breath_heavy";
			} else {
				private _random = selectRandom["mask_breath_1","mask_breath_2"];
				_player say3D _random;
			};
		};
	},
	5,
	[_player]
]call CBA_fnc_addPerFrameHandler;
