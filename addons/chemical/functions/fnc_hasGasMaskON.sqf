#include "script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Players googles (BOOL)
 *
 * Example:
 * [player] call kat_chemical_fnc_hasGasMaskOn;
 *
 * Public: No
 */

params ["_target"];

goggles _target in GVAR(availGasmaskList)
