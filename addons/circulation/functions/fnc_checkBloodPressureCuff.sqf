#include "..\script_component.hpp"
/*
 * Author: Glowbal modified by Cplhardcore
 * Checks the blood pressure of the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftArm"] call kat_circulation_fnc_checkBloodPressure
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(checkBloodPressureCuffLocal), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;