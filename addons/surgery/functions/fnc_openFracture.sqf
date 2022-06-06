#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Removes the fracture status from an open fracture
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_openFracture
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (local _patient) then {
    ["treatmentOpenFracture", [_medic, _patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentOpenFracture", [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};
