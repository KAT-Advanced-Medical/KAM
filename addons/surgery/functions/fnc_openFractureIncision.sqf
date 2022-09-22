#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Starts the surgical process for a fracture
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_openFractureIncision
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (local _patient) then {
    ["treatmentOpenFractureIncision", [_medic, _patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentOpenFractureIncision", [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};
