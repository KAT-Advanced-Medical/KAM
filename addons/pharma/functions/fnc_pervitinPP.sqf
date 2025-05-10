#include "..\script_component.hpp"
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
