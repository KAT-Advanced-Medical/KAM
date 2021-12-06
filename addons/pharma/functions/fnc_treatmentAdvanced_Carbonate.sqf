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

params ["_medic", "_patient", "_medication"];

["kat_Carbonate", _medic, _patient, "head", "Carbonate"] call acep_circulation_fnc_removeItemfromMag;

if (local _patient) then {
    ["treatmentCarbonate", [_medic, _patient, _medication]] call CBA_fnc_localEvent;
} else {
    ["treatmentCarbonate", [_medic, _patient, _medication], _patient] call CBA_fnc_targetEvent;
};

true;
