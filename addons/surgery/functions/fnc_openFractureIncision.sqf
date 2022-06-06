#include "script_component.hpp"
/*
 * Author: PabstMirror
 * Applies a splint to the patient on the given body part.
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
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splint
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

if (local _patient) then {
    ["treatmentOpenFractureIncision", [_medic, _patient, _bodyPart]] call CBA_fnc_localEvent;
} else {
    ["treatmentOpenFractureIncision", [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};
