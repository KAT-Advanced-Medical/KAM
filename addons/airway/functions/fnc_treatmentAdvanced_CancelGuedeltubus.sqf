#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Removing Guedeltubus
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_CancelGuedeltubus;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(cancelGuedeltubus), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
