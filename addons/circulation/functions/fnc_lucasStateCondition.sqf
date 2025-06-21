#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Attaches BVM to a Patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_breathing_fnc_attachBVM
 *
 * Public: No
 */

params ["_patient", "_state"];
private _lucas = _patient getVariable [QGVAR(attachedLucas), false];
private _lucasState = _patient getVariable [QGVAR(attachedLucasState), false];
if ((_lucas) && (_lucasState == _state)) exitWith {true};
false
