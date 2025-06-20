#include "..\script_component.hpp"
/*
 * Author: Mazinski, Cplhardcore
 * Ends the treatment cycle for a chest tube
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
 * [player, cursorObject, 1] call ka__breathing_treatmentAdvanced_chestTube
 
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(cricothyrotomy), [_medic, _patient], _patient] call CBA_fnc_targetEvent;