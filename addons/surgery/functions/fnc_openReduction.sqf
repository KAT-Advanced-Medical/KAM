#include "..\script_component.hpp"
/*
 * Author: Mazinski
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_openReduction
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(openReduction), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
