#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Begins Carbonate Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Carbonate;
 *
 * Public: No
 */

params ["_medic", "_patient", "_medication"];

["kat_Carbonate", _medic, _patient, "head", "Carbonate"] call FUNC(removeItemfromMag);

if (local _patient) then {
    ["treatmentCarbonate", [_medic, _patient, _medication]] call CBA_fnc_localEvent;
} else {
    ["treatmentCarbonate", [_medic, _patient, _medication], _patient] call CBA_fnc_targetEvent;
};

true;
