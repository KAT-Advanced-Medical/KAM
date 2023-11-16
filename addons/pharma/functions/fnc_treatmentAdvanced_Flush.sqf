#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Flushing IV access with saline
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "LeftArm"] call kat_pharma_fnc_treatmentAdvanced_Flush;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(flushLocal), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
