#include "script_component.hpp"
/*
 * Author: Blue
 * Detaches BVM from patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Is pocket BVM <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, false] call kat_breathing_fnc_detachBVM;
 *
 * Public: No
 */

params ["_medic", "_patient", "_pocket"];

if(_pocket) exitWith {
    [_medic, "kat_pocketBVM"] call ACEFUNC(common,addToInventory);
    _patient setVariable [QGVAR(pocketBVM), false, true];
};
[_medic, "kat_BVM"] call ACEFUNC(common,addToInventory);
_patient setVariable [QGVAR(BVM), false, true];

if (_patient getVariable [QGVAR(oxygenTankConnected), false]) then {
    _patient setVariable [QGVAR(oxygenTankConnected), false, true];
};
if (_patient getVariable [QGVAR(portableOxygenTankConnected), false]) then {
    _patient setVariable [QGVAR(portableOxygenTankConnected), false, true];
    _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
};