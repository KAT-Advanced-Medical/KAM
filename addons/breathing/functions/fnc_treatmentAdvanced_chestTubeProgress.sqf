#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Progresses the treatment process for a Chest Tube
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Current Chest Tube Status <NUMBER>
 * 3: Side <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "_entry", 1] call kat_breathing_treatmentAdvanced_chestTubeProgress;
 *
 * Public: No
 */

params ["_medic", "_patient", "_entry", "_side"];

[QGVAR(chestTubeProgress), [_medic, _patient, _entry, _side], _patient] call CBA_fnc_targetEvent;
