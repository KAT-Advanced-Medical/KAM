#include "script_component.hpp"
/*
 * Author: Blue
 * Sets if oxygen is connected to patient BVM
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Is connected <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, true] call kat_breathing_fnc_connectOxygen;
 *
 * Public: No
 */

params ["_patient","_connect"];

_patient setVariable [QGVAR(oxygenTankConnected), _connect, true];