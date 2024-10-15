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

if (!(isPlayer _patient) && GVAR(simpleMedicalEnable)) then { _patient setVariable [QGVAR(simpleMedical), true, true]; } else { _patient setVariable [QGVAR(simpleMedical), false, true]; };