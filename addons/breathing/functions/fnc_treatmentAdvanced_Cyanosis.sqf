#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks the cyanosis level of the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head"] call kat_breathing_fnc_checkCyanosis
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (local _patient) then {
    ["treatmentCyanosis", [_patient, _medic]] call CBA_fnc_localEvent;
} else {
    ["treatmentCyanosis", [_patient, _medic], _patient] call CBA_fnc_targetEvent;
};

true;