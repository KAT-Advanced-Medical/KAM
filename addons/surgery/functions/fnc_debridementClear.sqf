#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Clears all open wounds on a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_debridementClear
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (local _patient) then {
    ["treatmentDebridementClear", [_medic, _patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentDebridementClear", [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};
