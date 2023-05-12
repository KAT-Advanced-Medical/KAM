#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_canPutGasMask;
 *
 * Public: No
*/

params ["_medic", "_patient"];

!(_patient call ACEFUNC(common,isAwake)) && ([_medic,_patient] call FUNC(hasGasmask)) && !(goggles _patient in GVAR(availGasmaskList))
