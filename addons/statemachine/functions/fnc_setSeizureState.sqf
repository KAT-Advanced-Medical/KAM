#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Sets a unit in the seizure state. Called from enteredStateSeizure.
 *
 * Arguments:
 * 0: The unit that will be put in an unconscious state <OBJECT>
 * 1: Set seizure <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call kat_statemachine_fnc_setSeizureState
 *
 * Public: No
 */

 params ["_unit", "_active"];
 TRACE_2("setUnconsciousState",_unit,_active);

 if (_active isEqualTo IN_SEIZURE(_unit) || (!alive _unit)) exitWith {};

 _unit setVariable [VAR_SEIZURE, _active, true];

 [_unit, _active] call EFUNC(medical_engine,setUnconsciousAnim); //temporary, switch to seizure anim later