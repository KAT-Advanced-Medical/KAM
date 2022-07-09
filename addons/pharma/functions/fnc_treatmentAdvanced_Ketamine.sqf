#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Ketamine Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Ketamine;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentKetamine", [_patient, "Ketamine"]] call CBA_fnc_localEvent;
} else {
    ["treatmentKetamine", [_patient, "Ketamine"], _patient] call CBA_fnc_targetEvent;
};

true;