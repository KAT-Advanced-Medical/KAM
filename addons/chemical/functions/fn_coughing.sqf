#include "script_component.hpp"
///////////////////////////////

///////////////////////////////


waitUntil{ player getVariable["kat_medical_airPoisend",false] };

	private _lastcought = 0;
	while {player getVariable["kat_medical_airPoisend",false]} do {
		if(!(player getVariable ["ACE_isUnconscious",false]) && alive player) then {
			private _nextcought = random [20,50,80];
			waitUntil{(CBA_missionTime - _lastcought) > _nextcought};
			if (player getVariable["kat_medical_airPoisend",false]) then {
				_lastcought = CBA_missionTime;
				player say3D "cough_1";
				addCamShake [3, 4, 0];

				private _effect = ppEffectCreate ["ChromAberration",2005];
				KAT_PAIN_EFFECT = _effect;
				player setVariable ["KAT_PAIN_EFFECT",KAT_PAIN_EFFECT,true];
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
		};
		uiSleep 5;
	};

if(player getVariable["kat_medical_airPoisend",false]) exitWith {};
[] spawn FUNC(coughing);


