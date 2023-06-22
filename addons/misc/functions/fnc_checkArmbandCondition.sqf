#include "script_component.hpp"
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

[_unit, "kat_armband_red_cross"] call ACEFUNC(common,hasItem) || 
[_unit, "kat_armband_medic"] call ACEFUNC(common,hasItem) || 
[_unit, "kat_armband_doctor"] call ACEFUNC(common,hasItem) || 
[_unit, "kat_armband_kat"] call ACEFUNC(common,hasItem) || 
!(_unit getVariable [QGVAR(isRightArmFree), false]) || 
!(_unit getVariable [QGVAR(isLeftLegFree), false]) || 
!(_unit getVariable [QGVAR(isRightLegFree), false]) || 
!(_unit getVariable [QGVAR(isLeftArmFree), false]);
