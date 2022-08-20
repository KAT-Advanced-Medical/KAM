#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks the cyanosis level of the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_checkCyanosis
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(cyanosisLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
