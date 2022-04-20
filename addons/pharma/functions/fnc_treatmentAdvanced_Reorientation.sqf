#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins Reorientation Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Reorientation;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(GVAR(Reorientation_Enable)) exitWith{};

if (GVAR(Reorientation_Slap)) then {
playSound3D [QPATHTOF_SOUND(sounds\slap.ogg), _patient, false, getPosASL _patient, 10, 1, 15];
};

if (local _patient) then {
    ["treatmentReorientation", [_medic, _patient]] call CBA_fnc_localEvent;
} else {
    ["treatmentReorientation", [_medic, _patient], _patient] call CBA_fnc_targetEvent;
};

true;
