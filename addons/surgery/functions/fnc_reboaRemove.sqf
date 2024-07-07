#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Removes the REBOA from the patient.
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_reboaRemove
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(reboaRemove), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;