#include "..\script_component.hpp"
/*
 * Author: mharis001
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

params ["_this"];

if ((!(ACEGVAR(medical_statemachine,AIUnconsciousness))) && (!(_this getVariable [QEGVAR(conversion,convert),false])) && {!isPlayer _this}) exitWith {
    diag_log "TRUE";
    true
};

diag_log "FALSE";
false