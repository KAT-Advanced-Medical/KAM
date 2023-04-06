#include "script_component.hpp"
/*
 * Author: Blue
 * Attaches BVM to patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
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