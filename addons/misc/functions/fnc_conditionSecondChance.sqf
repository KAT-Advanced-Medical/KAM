#include "..\script_component.hpp"
/*
 * Author: mharis001
 * Modified: Blue
 * Condition for going into cardiac arrest upon receiving a fatal injury.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_conditionSecondChance
 *
 * Public: No
 */

params ["_unit"];

if (isPlayer _unit) then {
    ACEGVAR(medical_statemachine,fatalInjuriesPlayer) != FATAL_INJURIES_ALWAYS
} else {
    ACEGVAR(medical_statemachine,fatalInjuriesAI) != FATAL_INJURIES_ALWAYS || {_unit getVariable [QGVAR(PreventInstantAIDeath), false]}
};
