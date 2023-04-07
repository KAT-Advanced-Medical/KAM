#include "script_component.hpp"
/*
 * Author: Blue
 * Sets if portable oxygen tank is connected to patient BVM
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Is connected <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, true] call kat_breathing_fnc_connectPortableOxygenTank;
 *
 * Public: No
 */

params ["_medic","_patient","_connect"];

_patient setVariable [QGVAR(oxygenTankConnected), _connect, true];
if(_connect) then {
	_patient setVariable [QGVAR(oxygenTankProvider), _medic, true];
} else {
	_patient setVariable [QGVAR(oxygenTankProvider), nil, true];
};