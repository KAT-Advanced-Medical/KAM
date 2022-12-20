#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_coughing;
 *
 * Public: No
*/


[
	{ 
		params["_player"];
		_player getVariable [QGVAR(airPoisend),false];
	},
	{
		params["_player"];
		private _lastcought = 0;
		while {_player getVariable [QGVAR(airPoisend),false]} do {
			if(!(_player getVariable ["ACE_isUnconscious",false]) && alive _player) then {
				private _nextcought = random [20,50,80];
				[
					{
						params["_player","_lastcought","_nextcought"];
						(CBA_missionTime - _lastcought) > _nextcought;
					},
					{
						params["_player"];
						if (_player getVariable [QGVAR(airPoisend),false]) then {
							_lastcought = CBA_missionTime;
							_player say3D "cough_1";
							addCamShake [3, 4, 0];

							private _effect = ppEffectCreate ["ChromAberration",2005];
							KAT_PAIN_EFFECT = _effect;
							_player setVariable [QGVAR(painEffect),KAT_PAIN_EFFECT,true];
							KAT_PAIN_EFFECT ppEffectAdjust [0, 0, false];
							KAT_PAIN_EFFECT ppEffectCommit 0;
							KAT_PAIN_EFFECT ppEffectEnable true;
							private _intensity     = linearConversion [0, 1, 0.5, 0, 0.06, true];
							private _initialAdjust = [_intensity       , _intensity       , true];
							private _delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];
							KAT_PAIN_EFFECT ppEffectAdjust _initialAdjust;
							KAT_PAIN_EFFECT ppEffectCommit 0.3;

							[{
								params ["_adjust"];
								KAT_PAIN_EFFECT ppEffectAdjust _adjust;
								KAT_PAIN_EFFECT ppEffectCommit 0.7;
							}, [_delayedAdjust], 3] call CBA_fnc_waitAndExecute;
						};
					},
					[_player,_lastcought,_nextcought]
				] call CBA_fnc_waitUntilAndExecute;
				
			};
		};
	},
	[player]
] call CBA_fnc_waitUntilAndExecute;

if(player getVariable [QGVAR(airPoisend),false]) exitWith {};
[] call FUNC(coughing);
