#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Nalbuphine Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Nalbuphine;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentNalbuphine", [_patient, "Nalbuphine"]] call CBA_fnc_localEvent;
} else {
    ["treatmentNalbuphine", [_patient, "Nalbuphine"], _patient] call CBA_fnc_targetEvent;
};

true;