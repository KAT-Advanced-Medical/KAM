#include "script_component.hpp"
/*
 * Author: Blue
 * Check if medic has any kind of oxygen tank
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 
 * Return Value:
 * Has oxygen tank <BOOLEAN>
 *
 * Example:
 * [medic] call kat_breathing_fnc_hasOxygenTank;
 *
 * Public: No
 */

params ["_medic"];

if ([_medic, "kat_oxygenTank_150"] call ACEFUNC(common,hasMagazine) || [_medic, "kat_oxygenTank_300"] call ACEFUNC(common,hasMagazine)) exitWith {true};

false