#include "..\script_component.hpp"
/*
 * Author: commy2
 * Edited: Mazinski
 * Kills a local unit.
 *
 * Arguments:
 * 0: The unit <OBJECT>
 * 1: Reason for death <STRING>
 * 2: Killer <OBJECT>
 * 3: Instigator <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", ["_reason", "#setDead"], ["_source", objNull], ["_instigator", objNull]];
TRACE_4("setDead",_unit,_reason,_source,_instigator);

// If patient is marked for conversion, send them into arrest rather than killing them if the reason for dying is that they are AI
private _unitState = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;

if (GET_CONVERT_STATUS(_unit) && (_reason isEqualTo "CardiacArrest:DeathAI" || _reason isEqualTo "Unconscious:DeathAI")) exitWith {
    [_unit, ACEGVAR(medical,STATE_MACHINE), _unitState, "CardiacArrest"] call CBA_statemachine_fnc_manualTransition;
};

// No heart rate or blood pressure to measure when dead
_unit setVariable [VAR_HEART_RATE, 0, true];
_unit setVariable [VAR_BLOOD_PRESS, [0, 0], true];

// Clear uncon variable just to be safe
_unit setVariable [VAR_UNCON, nil, true];

_unit setVariable [QACEGVAR(medical,causeOfDeath), _reason, true];

// Send a local event before death
[QACEGVAR(medical,death), [_unit]] call CBA_fnc_localEvent;

// Update the state machine if necessary (forced respawn, scripted death, etc)
if (_unitState isNotEqualTo "Dead") then {
    [_unit, ACEGVAR(medical,STATE_MACHINE), _unitState, "Dead"] call CBA_statemachine_fnc_manualTransition;
};

// (#8803) Reenable damage if disabled to prevent having live units in dead state
// Keep this after death event for compatibility with third party hooks
if (!isDamageAllowed _unit) then {
    WARNING_1("setDead executed on unit with damage blocked - %1",_this);
    _unit allowDamage true;
};

// Kill the unit without changing visual apperance
private _prevDamage = _unit getHitPointDamage "HitHead";

_unit setHitPointDamage ["HitHead", 1, true, _source, _instigator];

_unit setHitPointDamage ["HitHead", _prevDamage, true, _source, _instigator];