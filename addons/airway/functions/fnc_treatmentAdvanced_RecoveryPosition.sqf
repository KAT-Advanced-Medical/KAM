#include "..\script_component.hpp"
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
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_RecoveryPosition;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_patient, "activity", LSTRING(RecoveryPosition_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(recoveryPositionLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
[_patient, "kat_recoveryPosition", 2] call ACEFUNC(common,doAnimation);
