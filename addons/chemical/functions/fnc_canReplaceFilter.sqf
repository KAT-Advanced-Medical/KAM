#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * BOOL
 *
 * Example:
 * [player] call kat_chemical_fnc_canReplaceFilter;
 *
 * Public: No
*/

params ["_target"];

if (goggles _target in GVAR(availGasmaskList) && 'kat_gasmaskFilter' in items _target) then {
    true
} else {
    false
};