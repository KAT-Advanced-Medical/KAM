#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Starts Atropine Treament
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Atropine;
 *
 * Public: Yes
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentAtropine", [_patient, "Atropine"]] call CBA_fnc_localEvent;
} else {
    ["treatmentAtropine", [_patient, "Atropine"], _patient] call CBA_fnc_targetEvent;
};

true;