#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Set patient into recovery position preventing further airway occlusion.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_RecoveryPosition
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_patient, "activity", LSTRING(RecoveryPosition_Log), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;

[QGVAR(recoveryPositionLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
