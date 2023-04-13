#include "script_component.hpp"
/*
 * Author: Blue
 * Check if patient can have BVM used on them
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 
 * Return Value:
 * Can use BVM <BOOLEAN>
 *
 * Example:
 * [patient] call kat_breathing_fnc_canUseBVM;
 *
 * Public: No
 */

params ["_patient"];

!(_patient call ACEFUNC(common,isAwake)) && !(_patient getVariable [QGVAR(BVMInUse), false]);