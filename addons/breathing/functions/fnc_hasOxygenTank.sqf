#include "..\script_component.hpp"
/*
 * Author: Blue
 * Check if target has any kind of oxygen tank
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Target is vehicle <BOOL>
 *
 * Return Value:
 * Has oxygen tank <BOOLEAN>
 *
 * Example:
 * [target] call kat_breathing_fnc_hasOxygenTank;
 *
 * Public: No
 */

params ["_target",["_isVehicle",false]];

if !(_isVehicle) exitWith {
    [_target, "kat_oxygenTank_150"] call ACEFUNC(common,hasMagazine) || [_target, "kat_oxygenTank_300"] call ACEFUNC(common,hasMagazine);
};

"kat_oxygenTank_150" in (magazineCargo _target) || "kat_oxygenTank_300" in (magazineCargo _target);
