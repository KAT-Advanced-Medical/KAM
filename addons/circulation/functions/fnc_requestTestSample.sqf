#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Mazinski
 * Reworked by Claude to ask the server for the authoritative result
 * Requests the server to test a blood sample stored at a vehicle.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Sample slot id <NUMBER>
 * 2: Vehicle the sample was tested at <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 3, vehicle] call kat_circulation_fnc_requestTestSample;
 *
 * Public: No
 */

params ["_player", "_idNumber", "_vehicle"];

[QGVAR(testSample), [_player, _vehicle, _idNumber]] call CBA_fnc_serverEvent;
