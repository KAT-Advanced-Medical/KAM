#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_ophthalmology_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_patient setVariable [QGVAR(dustInjuryLight), 0, true];
_patient setVariable [QGVAR(dustInjuryHeavy), 0, true];
_patient setVariable [QGVAR(eyeInjuries), [1,1], true];
_patient setVariable [QGVAR(eyeInjurySevere), false, true];