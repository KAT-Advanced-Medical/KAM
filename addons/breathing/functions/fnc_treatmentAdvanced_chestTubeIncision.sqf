#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Starts the surgical process for a fracture
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
 * [player, cursorObject, 1] call kat_surgery_fnc_incision
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

[QGVAR(chestTubeIncision), [_medic, _patient, _side], _patient] call CBA_fnc_targetEvent;
