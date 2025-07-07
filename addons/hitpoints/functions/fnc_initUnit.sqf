#include "..\script_component.hpp"
/*
 * Author: KoffeinFlummi, commy2
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Is Respawned <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, false] call ace_medical_status_fnc_initUnit
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];
TRACE_2("initUnit",_unit,_isRespawn);

if (!_isRespawn) then { // Always add respawn EH (same as CBA's onRespawn=1)
    _unit addEventHandler ["Respawn", {[(_this select 0), true] call FUNC(initUnit)}];
};

if (!local _unit) exitWith {};

if (damage _unit > 0) then {
    _unit setDamage 0;
};

if (_isRespawn) then {
    TRACE_1("reseting all vars on respawn",_isRespawn); // note: state is handled by ace_medical_statemachine_fnc_resetStateDefault
    _unit call FUNC(fullHealLocal);
    _unit setVariable [VAR_UNCON, false, true];

    // Triage card and logs
    _unit setVariable [QACEGVAR(medical,triageLevel), 0, true];
    _unit setVariable [QACEGVAR(medical,triageCard), [], true];

    // Unconscious spontanious wake up chance
    _unit setVariable [QACEGVAR(medical,lastWakeUpCheck), nil, true];

    // Cause of death
    _unit setVariable [QACEGVAR(medical,causeOfDeath), nil, true];
};

[{
    params ["_unit"];
    TRACE_3("Unit Init",_unit,local _unit,typeOf _unit);

    _unit setVariable [QACEGVAR(medical,initialized), true, true];
    [QACEGVAR(medical_status,initialized), [_unit]] call CBA_fnc_localEvent;
}, [_unit], 0.5] call CBA_fnc_waitAndExecute;