#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Selects the patient's fracture state
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_fractureSelect
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(fractureSelect), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
