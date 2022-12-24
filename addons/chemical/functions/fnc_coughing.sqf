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
params ["_unit"];

[
	{ 
		params["_unit"];
		_unit getVariable [QGVAR(airPoisend),false]
	},
	{
		params["__unit"];
		private _lastcought = 0;
		while {_unit getVariable [QGVAR(airPoisend),false]} do {
			if(!(_unit getVariable ["ACE_isUnconscious",false]) && alive _unit) then {
				private _nextcought = random [20,50,80];
				[
					{
						params["__unit","_lastcought","_nextcought"];
						(CBA_missionTime - _lastcought) > _nextcought;
					},
					{
						params["__unit"];
						if (_unit getVariable [QGVAR(airPoisend),false]) then {
							_lastcought = CBA_missionTime;
							_unit say3D QGVAR(cough_1);
							addCamShake [3, 4, 0];

							private _effect = ppEffectCreate ["ChromAberration",2005];
							KAT_PAIN_EFFECT = _effect;
							_unit setVariable [QGVAR(painEffect),KAT_PAIN_EFFECT,true];
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
					[_unit,_lastcought,_nextcought]
				] call CBA_fnc_waitUntilAndExecute;
				
			};
		};
		if(!(_unit getVariable [QGVAR(airPoisend),false])) then {
			[] call FUNC(coughing);
		};
	},
	[_unit]
] call CBA_fnc_waitUntilAndExecute;
