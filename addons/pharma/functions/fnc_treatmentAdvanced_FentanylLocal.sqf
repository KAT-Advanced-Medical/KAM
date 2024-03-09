#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Modified: Mazinski
 * Triggers the fentanyl visual effect and applies the opioid factor from Fentanyl.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Bodypart <STRING>
 * 2: OpioidRelief <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftLeg", 1] call kat_pharma_fnc_treatmentAdvanced_FentanylLocal;
 *
 * Public: No
 */

params ["_target", "_bodyPart", "_opioidRelief"];

if !(alive _target) exitWith {};
if (ACE_Player != _target) exitWith {};

private _opioidFactor = _target getVariable [QGVAR(opioidFactor), 1];
if (_opioidFactor == 1) then {
    _target setVariable [QGVAR(opioidFactor), _opioidRelief, true];
};

/// ChromAberration effect
if (GVAR(chromatic_aberration_checkbox_fentanyl)) then {
    [{
        params ["_target"];

        ["ChromAberration", 200, [(GVAR(chromatic_aberration_slider_fentanyl)/100), (GVAR(chromatic_aberration_slider_fentanyl)/100), true ], "", _target] spawn {

            params ["_name", "_priority", "_effect", "_handle", "_target"];
            while {
                _handle = ppEffectCreate[_name, _priority];
                _handle < 0
            } do {
                _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 180; // 6m for max chroma

            [{    params["_handle"];

                [{  params["_handle"];
                    ppEffectCommitted _handle
                },
                {    params["_handle"];
                    _handle ppEffectAdjust [0.005, 0.005, false];
                    _handle ppEffectCommit 480; // lowering until 15m

                    [{  params["_handle"];
                        ppEffectCommitted _handle
                    },
                    {    params["_handle"];
                        _handle ppEffectEnable false;
                        ppEffectDestroy _handle;

                    }, [_handle]] call CBA_fnc_waitUntilAndExecute;

                }, [_handle]] call CBA_fnc_waitUntilAndExecute;
            },
            [_handle], 360] call CBA_fnc_waitAndExecute; // wait until 7m for change to lower again
        };
    },
    [_target], 60] call CBA_fnc_waitAndExecute; // chroma start after 60s
};
