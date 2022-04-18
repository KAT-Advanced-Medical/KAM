#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins Naloxone Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Naloxone;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentNaloxone", [_patient, "Naloxone"]] call CBA_fnc_localEvent;
} else {
    ["treatmentNaloxone", [_patient, "Naloxone"], _patient] call CBA_fnc_targetEvent;
};

true;