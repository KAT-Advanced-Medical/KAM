#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_vitals_fnc_handleRespawn
 *
 * Public: No
 */

params ["_patient"];

if (!(isPlayer _unit) && GVAR(simpleMedical)) then { _patient setVariable [QGVAR(simpleMedical), true, true] };