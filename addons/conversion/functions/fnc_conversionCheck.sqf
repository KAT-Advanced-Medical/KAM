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

params ["_unit"];

if ((!(ACEGVAR(medical_statemachine,AIUnconsciousness))) && (!isPlayer _unit) && LIB_CONVERSION_DISTANCE(_unit)) then {
    GET_CONVERT_STATUS(_unit) != true
}