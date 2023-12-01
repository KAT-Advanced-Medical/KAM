#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Set patient into recovery position preventing further airway occlusion.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Hint is delayed? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_CancelRecoveryPosition;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_delayed", false]];

[_patient, "activity", LSTRING(CancelRecoveryPosition_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(cancelRecoveryPositionLocal), [_medic, _patient, _delayed], _patient] call CBA_fnc_targetEvent;
[_patient, "ainjppnemstpsnonwrfldnon", 2] call ACEFUNC(common,doAnimation);
