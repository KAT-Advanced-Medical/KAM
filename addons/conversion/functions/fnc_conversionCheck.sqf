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

params ["_patient"];

if ((!(ACEGVAR(medical_statemachine,AIUnconsciousness))) && (!(_patient getVariable [QGVAR(convert),false])) && {!isPlayer _patient}) exitWith {
    true
};

false