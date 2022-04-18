#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins TXA Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_TXA;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentTXA", [_patient, "TXA"]] call CBA_fnc_localEvent;
} else {
    ["treatmentTXA", [_patient, "TXA"], _patient] call CBA_fnc_targetEvent;
};

true;