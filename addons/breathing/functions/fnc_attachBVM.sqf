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
 * [player, cursorTarget] call kat_breathing_fnc_attachBVM;
 *
 * Public: No
 */

params ["_patient","_pocket"];

if(_pocket) exitWith {_patient setVariable [QGVAR(pocketBVM), true, true];};
_patient setVariable [QGVAR(BVM), true, true];