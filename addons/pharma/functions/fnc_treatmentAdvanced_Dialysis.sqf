#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Treatment call for dialysis procedure
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_surgery_fnc_treatmentAdvanced_Dialysis
 *
 * Public: Yes
 */

params ["_medic", "_patient"];

[QGVAR(dialysisLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
