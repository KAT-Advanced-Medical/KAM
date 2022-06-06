#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_accuvac;
 *
 * Public: Yes
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentFlush", [_medic, _patient]] call CBA_fnc_localEvent;
} else {
    ["treatmentFlush", [_medic, _patient], _patient] call CBA_fnc_targetEvent;
};

true;