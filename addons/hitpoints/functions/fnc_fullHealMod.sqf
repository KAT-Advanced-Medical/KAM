#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_treatment_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealMod",_patient);

_patient setVariable [QGVAR(isApplyingPressure), false, true];
_patient setVariable [QGVAR(evisceration), 0, true];
_patient setVariable [QGVAR(activeWoundPack), 0, true];