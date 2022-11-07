#include "script_component.hpp"
/*
 * Author: Katalam
 * Treatment for a pulmo injury
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
 * call kat_breathing_fnc_treatmentAdvanced_chestSeal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(chestSealLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
