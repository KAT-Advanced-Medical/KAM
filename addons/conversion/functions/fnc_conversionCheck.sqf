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
_result = false;
if ((!(ACEGVAR(medical_statemachine,AIUnconsciousness)))  && (!isPlayer _unit)) then {
    _result = !((GET_CONVERT_STATUS(_unit)) || (_unit getVariable [QACEGVAR(medical_statemachine,AIUnconsciousness), false]));
};
_result