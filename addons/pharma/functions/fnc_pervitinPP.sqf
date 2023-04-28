#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Triggers the perivin visual effect.
 *
 * Arguments:
 * 0: Target <object>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_pervitinPP
 *
 * Public: No
 */

params ["_target"];

if (GVAR(chromatic_aberration_checkbox_pervitin)) then {
    [{
        params ["_target"];

        if !(alive _target) exitWith {};
        ["ChromAberration", 200, [ (GVAR(chromatic_aberration_slider_pervitin)/100), (GVAR(chromatic_aberration_slider_pervitin)/100), true ], "", _target] spawn {

            params ["_name", "_priority", "_effect", "_handle", "_target"];
            while {
                _handle = ppEffectCreate[_name, _priority];
                _handle < 0
            } do {
                _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 120; // 2m for max chroma
            [LLSTRING(Pervitin_chrom), 2, _target] call ACEFUNC(common,displayTextStructured);
            
            [{    params["_handle"];
                
                [{  params["_handle"];
                    ppEffectCommitted _handle
                }, 
                {    params["_handle"];
                    _handle ppEffectAdjust [0.005, 0.005, false];
                    _handle ppEffectCommit 257.5; // lowering until 9m

                    [{  params["_handle"];
                        ppEffectCommitted _handle
                    }, 
                    {    params["_handle"];
                        _handle ppEffectEnable false;
                        ppEffectDestroy _handle;

                    }, [_handle]] call CBA_fnc_waitUntilAndExecute;

                }, [_handle]] call CBA_fnc_waitUntilAndExecute;
            },
            [_handle], 257.5] call CBA_fnc_waitAndExecute; // wait until 4:30m for change to lower again
        };
    },
    [_target], 25] call CBA_fnc_waitAndExecute; // chroma start after 25s
};

// CamShake effect
[{
    if !(alive _target) exitWith {};
    [LLSTRING(Pervitin_chrom2), 2, _target] call ACEFUNC(common,displayTextStructured);
    addCamShake[1, 180, 2]; // wearoff after 9m
    [{
        [LLSTRING(Pervitin_chrom3), 2, _target] call ACEFUNC(common,displayTextStructured);
    }, 
    [_target], 180] call CBA_fnc_waitAndExecute;
}, 
[_target], 360] call CBA_fnc_waitAndExecute; // after 6m start