#include "script_component.hpp"
/*
 * Author: Miss Heda 
 * Triggers the ketamine visual effect.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_ketaminePP;
 *
 * Public: No
 */


/// ChromAberration effect

if (GVAR(chromatic_aberration_checkbox_ketamine)) then {
    [
        { 
            params ["_patient"];
            
            if (ACE_Player != _patient) exitWith {};
            if !(alive _patient) exitWith {};
            ["ChromAberration", 200, [(GVAR(chromatic_aberration_slider_ketamine)/100), (GVAR(chromatic_aberration_slider_ketamine)/100), true ], _patient] spawn {

                params["_name", "_priority", "_effect", "_patient"];
                private "_handle";
                while {
                    _handle = ppEffectCreate[_name, _priority];
                    _handle < 0
                } do {
                    _priority = _priority + 1;
                };
                _handle ppEffectEnable true;
                _handle ppEffectAdjust _effect;
                _handle ppEffectCommit 660; /// Wearoff after 13m (after injection)

                [
                    { 	params ["_handle"];
                        ppEffectCommitted _handle;
                    },
                    {	params ["_handle"];
                        _handle ppEffectEnable false;
                        ppEffectDestroy _handle;
                    },
                    [_handle]
                ] call CBA_fnc_waitUntilAndExecute;
            };
        },
    [_patient],120] call CBA_fnc_waitAndExecute; /// chroma start 2m
};


if (GVAR(chromatic_aberration_checkbox_pervitin)) then {
	[{
		params ["_target"];

		if !(alive _target) exitWith {};
		["ChromAberration", 200, [(GVAR(chromatic_aberration_slider_ketamine)/100), (GVAR(chromatic_aberration_slider_ketamine)/100), true ], "", _target] spawn {

			params ["_name", "_priority", "_effect", "_handle", "_target"];
			while {
				_handle = ppEffectCreate[_name, _priority];
				_handle < 0
			} do {
				_priority = _priority + 1;
			};
			_handle ppEffectEnable true;
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 360;
			
			[{	params["_handle"];
				
				[{  params["_handle"];
					ppEffectCommitted _handle
				}, 
				{	params["_handle"];
					_handle ppEffectAdjust [0.005, 0.005, false];
					_handle ppEffectCommit 480; //lowering until 15m

					[{  params["_handle"];
						ppEffectCommitted _handle
					}, 
					{	params["_handle"];
						_handle ppEffectEnable false;
						ppEffectDestroy _handle;

					}, [_handle]] call CBA_fnc_waitUntilAndExecute;

				}, [_handle]] call CBA_fnc_waitUntilAndExecute;
			},
			[_handle], 360] call CBA_fnc_waitAndExecute; // wait until 7m for change to lower again
		};
	},
	[_target], 60] call CBA_fnc_waitAndExecute; // 60s chroma start
};