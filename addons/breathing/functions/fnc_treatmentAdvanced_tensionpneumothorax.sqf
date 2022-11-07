#include "script_component.hpp"
/*
 * Author: Kygan
 * Treatment for hemopneumothorax
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
 * call kat_breathing_fnc_treatmentAdvanced_tensionpneumothorax;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(tensionpneumothoraxLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
