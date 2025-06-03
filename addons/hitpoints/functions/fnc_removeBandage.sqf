#include "..\script_component.hpp"
/*
 * Author: Mazinski
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_closedReduction
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_type"];

[QGVAR(removeBandage), [_patient, _bodyPart, _type], _patient] call CBA_fnc_targetEvent;
