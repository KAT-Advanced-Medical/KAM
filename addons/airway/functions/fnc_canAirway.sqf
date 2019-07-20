#include "script_component.hpp"
/*
 * Author: Katalam
 * Checks if airway management is possible.
 * Endotracheal requires unconscious patient.
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

params ["", "_target", "", "_className"];

// Exit if airway is disabled
if !(GVAR(enable)) exitWith {false};

// Exit if the same already exist
private _classNameStored = _target getVariable [QGVAR(airway), [false, ""]] select 1 select [4]; // item name is stored not treatment className
if (_classNameStored isEqualTo _className) exitWith {false};

if (_className isEqualTo "Endotracheal") then {
    if ([_target] call ace_common_fnc_isAwake) exitWith {false};
};

true
