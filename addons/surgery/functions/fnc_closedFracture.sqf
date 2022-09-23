#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Fully heals a fracture on the selected limb.
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_closedFracture
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (local _patient) then {
    ["treatmentClosedFracture", [_medic, _patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentClosedFracture", [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};