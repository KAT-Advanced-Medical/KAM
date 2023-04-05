#include "script_component.hpp"
/*
 * Author: Blue
 * Handles BVM usage
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_handleBVMUsage;
 *
 * Public: No
 */

params ["_patient", ["_active",false]];

if(!_active) exitWith {_patient setVariable [QGVAR(BVMInUse), false, true];};
_patient setVariable [QGVAR(BVMInUse), true, true];