#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Removes the fracture status from an open fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_chestTube
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

[QGVAR(chestTube), [_medic, _patient, _side], _patient] call CBA_fnc_targetEvent;
