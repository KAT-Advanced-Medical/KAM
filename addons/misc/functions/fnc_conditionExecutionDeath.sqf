#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Modified: Blue
 * Condition for an execution caused death (fatal injury received in cardiac arrest).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_conditionExecutionDeath
 *
 * Public: No
 */

params ["_unit"];

(if (isPlayer _unit) then {
    ACEGVAR(medical_statemachine,fatalInjuriesPlayer) != FATAL_INJURIES_NEVER
} else {
    (ACEGVAR(medical_statemachine,fatalInjuriesAI) != FATAL_INJURIES_NEVER) && {!(_unit getVariable [QGVAR(PreventInstantAIDeath), false])}
})
&& {!(_unit getVariable [QACEGVAR(medical,deathBlocked), false])}
