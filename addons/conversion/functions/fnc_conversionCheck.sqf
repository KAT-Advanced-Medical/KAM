#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Condition for automatic conversion
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_conversionCheck
 *
 * Public: No
 */

params ["_this"];

if ((!(ACEGVAR(medical_statemachine,AIUnconsciousness))) && (!(_this getVariable [QEGVAR(conversion,convert),false])) && {!isPlayer _this}) exitWith {
    true
};

false