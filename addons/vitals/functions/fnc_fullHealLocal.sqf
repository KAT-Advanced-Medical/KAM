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
 * [player] call kat_vitals_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(simpleMedical), false, true];

if (GVAR(enableSimpleMedical)) then {
    _patient setVariable [QGVAR(simpleMedical), true, true];
};
