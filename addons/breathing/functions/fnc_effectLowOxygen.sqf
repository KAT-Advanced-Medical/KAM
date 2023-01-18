#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Triggers the low SPO2 visual effect.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call kat_breathing_fnc_effectLowOxygen
 *
 * Public: No
 */

params ["_enable"];

if (_enable) then {
    ["ColorCorrections", 1500, [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]]] spawn
    {
        params ["_name", "_priority", "_effect", "_handle"];
        while {
            _handle = ppEffectCreate [_name, _priority];
            _handle < 0
        } do {
            _priority = _priority + 1;
        };
        _handle ppEffectEnable true;
        _handle ppEffectAdjust _effect;
        _handle ppEffectCommit 0.7;
        [{  params["_handle"];
            ppEffectCommitted _handle
        }, 
        {   params["_handle"];          
            _handle ppEffectAdjust [1, 1, 0, [0, 0, 0, 0.9], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
            _handle ppEffectCommit 0.7;
            [{  params["_handle"];
                ppEffectCommitted _handle
            }, 
            {   params["_handle"];
                _handle ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0.33, 0.33, 0.33, 0], [0.55, 0.5, 0, 0, 0, 0, 4]];
                _handle ppEffectCommit 1.6;       

                [{  params["_handle"];
                    ppEffectCommitted _handle
                }, 
                {   params["_handle"];           
                    _handle ppEffectEnable false;
                    ppEffectDestroy _handle;
                }, [_handle]] call CBA_fnc_waitUntilAndExecute;
            }, [_handle]] call CBA_fnc_waitUntilAndExecute;
        }, [_handle]] call CBA_fnc_waitUntilAndExecute;
    };
};