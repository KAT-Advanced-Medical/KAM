#include "script_component.hpp"
/*
 * Author: Katalam
 * docks a pulseoximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_pulseoximeter;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(pulseoxLocal), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;