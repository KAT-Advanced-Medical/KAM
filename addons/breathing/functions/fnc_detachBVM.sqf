#include "script_component.hpp"
/*
 * Author: Blue
 * Detaches BVM from patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_detachBVM;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_medic, "kat_BVM"] call ACEFUNC(common,addToInventory);
_patient setVariable [QGVAR(BVM), false, true];