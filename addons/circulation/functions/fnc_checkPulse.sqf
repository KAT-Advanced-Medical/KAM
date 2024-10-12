#include "..\script_component.hpp"
/*
 * Author: Glowbal modified by Cplhardcore
 * Checks the pulse or heart rate of the patient.
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
 * [player, cursorObject, "Head"] call kat_circulation_fnc_checkPulse
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(checkPulseLocal), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;