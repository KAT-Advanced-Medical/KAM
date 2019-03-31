#include "script_component.hpp"

["treatmentIVfalse", {_this call FUNC(treatmentAdvanced_IV)}] call CBA_fnc_addEventHandler;
["IVreset", {_this call FUNC(removeEffect_IV)}] call CBA_fnc_addEventHandler;

if (hasInterface) then {

    GVAR(CrossPanelOpened) = false;

    private _fnc_createEffect = {
        params ["_type", "_layer", "_default"];

        private _effect = ppEffectCreate [_type, _layer];
        _effect ppEffectEnable true;
        _effect ppEffectForceInNVG true;
        _effect ppEffectAdjust _default;
        _effect ppEffectCommit 0;

        _effect
    };

    GVAR(effect_IV) = [
        "chromAberration",
        4207,
        [0, 0, false]
    ] call _fnc_createEffect;


    [{
        private _counts = ACE_PLAYER getVariable [QGVAR(IV_counts), 0];
        if (_counts > 0) then {
            private _ppEffect = (0.01 * _counts);
            GVAR(effect_IV) ppEffectEnable true;
            GVAR(effect_IV) ppEffectAdjust [_ppEffect, _ppEffect, false];
            GVAR(effect_IV) ppEffectCommit 0.01;
        } else {
            GVAR(effect_IV) ppEffectEnable true;
            GVAR(effect_IV) ppEffectAdjust [0, 0, false];
            GVAR(effect_IV) ppEffectCommit 0.01;
        };

        if (!(isNull curatorCamera) or !(alive ACE_player)) exitWith {
            GVAR(effect_IV) ppEffectEnable false;
        };
    }, 0.5, []] call CBA_fnc_addPerFrameHandler;
};
