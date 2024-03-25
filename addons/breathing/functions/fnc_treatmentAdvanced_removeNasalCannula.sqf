#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Removes Nasal Cannula from patient and returns it to medic if reusable airway items is enabled
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_treatmentAdvanced_removeNasalCannula;
 *
 * Public: No
 */

 params ["_medic", "_patient"];

[QGVAR(removeNasalCannulaLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;