#include "..\script_component.hpp"
/*
 * Author: mharis001
 * Edited: Blue, Mazinski.H
 * Condition for going into cardiac arrest upon receiving a fatal injury.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_conditionSecondChance
 *
 * Public: No
 */

params ["_unit"];

if (isPlayer _unit || (GET_CONVERT_STATUS(_unit))) then {
    ACEGVAR(medical_statemachine,fatalInjuriesPlayer) != FATAL_INJURIES_ALWAYS
} else {
    ACEGVAR(medical_statemachine,fatalInjuriesAI) != FATAL_INJURIES_ALWAYS || {_unit getVariable [QEGVAR(misc,PreventInstantAIDeath), false]}
}