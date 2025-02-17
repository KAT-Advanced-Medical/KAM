#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks all basic patient vitals (HR/BP/RR)
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_vitals_fnc_basicDiagnostic
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(basicDiagnosticLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;