#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Digii
 * Modified by MiszczuZPolski
 * Triggers the low SPO2 visual effect.
 *
* Arguments:
 * 0: Enable <BOOL>
 * 1: Injury <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectEyeInjury;
 *
 * Public: No
 */

params ["_enable", "_injury"];

if (_enable) then {
    if (_injury) then {
        if (GVAR(eyeInjury) != -1) then { GVAR(eyeInjury) ppEffectEnable true; };
    } else {
        if (GVAR(eyeInjury) != -1) then { GVAR(eyeInjury) ppEffectEnable false; };
    };
} else {
    if (GVAR(eyeInjury) != -1) then { GVAR(eyeInjury) ppEffectEnable false; };
};
