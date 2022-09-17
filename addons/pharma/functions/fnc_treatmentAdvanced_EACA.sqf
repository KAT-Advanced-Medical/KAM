#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Handles EACA treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [_medic, _patient] call kat_pharma_fnc_treatmentAdvanced_EACA;
 *
 * Public: Yes
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentEACA", [_patient, "EACA", _medic]] call CBA_fnc_localEvent;
} else {
    ["treatmentEACA", [_patient, "EACA", _medic], _patient] call CBA_fnc_targetEvent;
};

true;
