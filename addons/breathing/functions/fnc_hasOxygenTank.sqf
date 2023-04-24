#include "script_component.hpp"
/*
 * Author: Blue
 * Check if unit has any kind of oxygen tank
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 
 * Return Value:
 * Has oxygen tank <BOOLEAN>
 *
 * Example:
 * [medic] call kat_breathing_fnc_hasOxygenTank;
 *
 * Public: No
 */

params ["_unit"];

[_unit, "kat_oxygenTank_150"] call ACEFUNC(common,hasMagazine) || [_unit, "kat_oxygenTank_300"] call ACEFUNC(common,hasMagazine);