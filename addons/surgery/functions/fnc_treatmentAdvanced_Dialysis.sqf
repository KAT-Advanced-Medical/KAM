#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Treatment call for dialysis procedure
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_surgery_fnc_treatmentAdvanced_Dialysis
 *
 * Public: Yes
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentDialysis", [_medic, _patient]] call CBA_fnc_localEvent;
} else {
    ["treatmentDialysis", [_medic, _patient], _patient] call CBA_fnc_targetEvent;
};

true;
