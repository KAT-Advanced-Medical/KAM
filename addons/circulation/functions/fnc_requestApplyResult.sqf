#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Reworked by Claude to ask the server for the authoritative result
 * Requests the server to apply a blood gas test result to a patient.
 *
 * Arguments:
 * 0: Patient the result is applied to <OBJECT>
 * 1: Result slot id <NUMBER>
 * 2: Medic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [patient, 5, player] call kat_circulation_fnc_requestApplyResult;
 *
 * Public: No
 */

params ["_target", "_idNumber", "_player"];

[QGVAR(applyResult), [_player, _target, _idNumber]] call CBA_fnc_serverEvent;
