#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Runs the Pericardial Tap.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject] call kat_surgery_pericardialTap
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(pericardialTap), [_medic, _patient], _patient] call CBA_fnc_targetEvent;