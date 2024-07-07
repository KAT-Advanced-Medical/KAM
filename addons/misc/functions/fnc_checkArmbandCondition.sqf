#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Checks if conditions are met for armband parent option to be displayed
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player] call kat_misc_fnc_checkArmbandCondition;
 *
 * Public: No
 */

params ["_unit"];

[_unit, "kat_Armband_Red_Cross_Goggles"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Medic_Goggles"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Doctor_Goggles"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Kat_Goggles"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Red_Cross_NVG"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Medic_NVG"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Doctor_NVG"] call ACEFUNC(common,hasItem) ||
[_unit, "kat_Armband_Kat_NVG"] call ACEFUNC(common,hasItem) ||
!(_unit getVariable [QGVAR(isRightArmFree), false]) ||
!(_unit getVariable [QGVAR(isLeftLegFree), false]) ||
!(_unit getVariable [QGVAR(isRightLegFree), false]) ||
!(_unit getVariable [QGVAR(isLeftArmFree), false]);
