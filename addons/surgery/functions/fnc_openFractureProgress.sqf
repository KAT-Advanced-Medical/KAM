#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Progresses the treatment process for a complex fracture
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Current Fracture Status <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "_entry"] call kat_surgery_fnc_openFractureProgress
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_entry"];

if (local _patient) then {
    ["treatmentOpenFractureProgress", [_medic, _patient, _bodyPart, _entry]] call CBA_fnc_localEvent;
} else {
    ["treatmentOpenFractureProgress", [_medic, _patient, _bodyPart, _entry], _patient] call CBA_fnc_targetEvent;
};
