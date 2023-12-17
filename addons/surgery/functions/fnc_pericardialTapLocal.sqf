#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for running the Pericardial Tap.
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_ultraAssessmentLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

_patient setVariable [QEGVAR(circulation,effusion), 0, true];

