/*
 * Author: Katalam
 * CBA Events function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceCirculation_fnc_events;
 *
 * Public: No
 */

["treatmentIVfalse", {_this call kat_aceCirculation_fnc_treatmentAdvanced_IV}] call CBA_fnc_addEventHandler;
["IVreset", {_this call kat_aceCirculation_fnc_removeEffect_IV}] call CBA_fnc_addEventHandler;

if (hasInterface) then {

	KAT_CrossPanelOpened = false;

	private _fnc_createEffect = {
	    params ["_type", "_layer", "_default"];

	    private _effect = ppEffectCreate [_type, _layer];
		_effect ppEffectEnable true;
	    _effect ppEffectForceInNVG true;
	    _effect ppEffectAdjust _default;
	    _effect ppEffectCommit 0;

	    _effect
	};

	kat_aceCirculation_effect_IV = [
	    "chromAberration",
	    4207,
	    [0, 0, false]
	] call _fnc_createEffect;


	[{
		private _counts = ACE_PLAYER getVariable ["kat_aceCirculation_IV_counts", 0];
		if (_counts > 0) then {
			private _ppEffect = (0.01 * _counts);
			kat_aceCirculation_effect_IV ppEffectEnable true;
			kat_aceCirculation_effect_IV ppEffectAdjust [_ppEffect, _ppEffect, false];
			kat_aceCirculation_effect_IV ppEffectCommit 0.01;
		} else {
			kat_aceCirculation_effect_IV ppEffectEnable true;
			kat_aceCirculation_effect_IV ppEffectAdjust [0, 0, false];
			kat_aceCirculation_effect_IV ppEffectCommit 0.01;
		};

	    if (!(isNull curatorCamera) or !(alive ACE_player)) exitWith {
	        kat_aceCirculation_effect_IV ppEffectEnable false;
	    };
	}, 0.5, []] call CBA_fnc_addPerFrameHandler;
};
