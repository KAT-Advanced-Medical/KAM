#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Mazinski
 * Refactored by Slatery
 * Reworked by Claude to ask the server for the authoritative result
 * Handles drawing of arterial blood
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, patient] call kat_circulation_fnc_drawArterial;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(drawSample), [_medic, _patient]] call CBA_fnc_serverEvent;
