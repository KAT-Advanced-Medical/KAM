#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a pulseoximeter for a patient and adds Item to the caller
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_removePulseoximeter;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(pulseoximeter), false, true];

[_medic, "kat_Pulseoximeter", 1] call ACEFUNC(common,addToInventory);
