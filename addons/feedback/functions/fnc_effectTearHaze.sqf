#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski & Digii
 * Enables or disables the wet distortion haze that blurs the vision while in tear gas.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Tear gas exposure, 0 disables the effect <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 1] call kat_feedback_fnc_effectTearHaze;
 *
 * Public: No
 */

params ["_enable", "_tear"];
if (!_enable || _tear == 0) exitWith {
    if (GVAR(tearHaze) != -1) then { GVAR(tearHaze) ppEffectEnable false; };
};
if (GVAR(tearHaze) != -1) then { GVAR(tearHaze) ppEffectEnable true; };

GVAR(tearHaze) ppEffectAdjust [1.5,0.3,0.3,1.02,1.02,1.02,1.02,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];
GVAR(tearHaze) ppEffectCommit 0;
