#include "script_component.hpp"

params ["_unit"];

if !(GVAR(enable)) exitWith {};
_unit call FUNC(init);
//[player getVariable ["KAT_medical_airwayStatus", 100] < 70] call ace_medical_fnc_addUnconsciousCondition;

/*private _stateMachine = [[player], true] call CBA_statemachine_fnc_create;

[_stateMachine, {}, {[player, false] call ace_medical_fnc_setUnconscious}, {}, "Spo2_Normal"] call CBA_statemachine_fnc_addState;
[_stateMachine, {}, {if (player getVariable ["KAT_medical_airwayStatus", 100] < 70) then {[player, true, 0, false] call ace_medical_fnc_setUnconscious}}, {}, "Spo2_Low"] call CBA_statemachine_fnc_addState;

[_stateMachine, "Spo2_Normal", "Spo2_Low", {player getVariable ["KAT_medical_airwayStatus", 100] < 70}, {
	//OnEntredCode
}, "Spo2_Statemachine"] call CBA_statemachine_fnc_addTransition;
diag_log "Statemachine is set";*/

//private _currentState = [_unit, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
//[_unit, ace_medical_STATE_MACHINE, _currentState, "Unconscious", {}, "MANUAL"] call CBA_statemachine_fnc_manualTransition;

if (GVAR(pneumothorax) == 0) exitWith {};
_unit addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "", "_projectile"];
    [_unit, _selection, _damage, _projectile] call FUNC(handlePulmoHit);
}];
