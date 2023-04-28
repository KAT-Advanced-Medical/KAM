#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Removing Larynxtubus
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_CancelLarynxtubus.sqf
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(cancelLarynxtubus), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
