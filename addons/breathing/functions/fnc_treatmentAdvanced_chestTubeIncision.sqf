#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Starts the surgical process for a chest tube
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
 * [player, cursorObject, 1] call kat_breathing_treatmentAdvanced_chestTubeIncision
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

[QGVAR(chestTubeIncision), [_medic, _patient, _side], _patient] call CBA_fnc_targetEvent;
