#include "script_component.hpp"
/*
 * Author: Katalam
 * Checks if airway management is possible.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * ReturnValue:
 * Can Airway <BOOL>
 *
 * Public: No
 */

params ["", "_patient"];

// Exit if airway is disabled
if !(GVAR(enable)) exitWith {false};
if ([_patient] call ace_common_fnc_isAwake) exitWith {false};
if !(_patient getVariable [QGVAR(obstruction), false]) exitWith {false};
true;
