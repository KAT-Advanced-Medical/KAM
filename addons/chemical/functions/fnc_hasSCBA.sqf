#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Players SCBA in backpack slot (BOOL)
 *
 * Example:
 * [player] call kat_chemical_fnc_hasSCBA;
 *
 * Public: No
 */

params ["_target"];

if (missionNamespace getVariable [QGVAR(availBackpackList), []] isEqualTo []) exitWith {false};

backpack _target in (missionNamespace getVariable [QGVAR(availBackpackList), []]);
