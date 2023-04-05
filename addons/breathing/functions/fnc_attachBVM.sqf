#include "script_component.hpp"
/*
 * Author: Blue
 * Attaches BVM to patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_attachBVM;
 *
 * Public: No
 */

params ["_medic", "_patient"];

//_medic RemoveItem "kat_BVM";
_patient setVariable [QGVAR(BVM), true, true];