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
 * [player, cursorTarget] call kat_airway_fnc_RecoveryPosition
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(cancelRecoveryPositionLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
[_patient, "ainjppnemstpsnonwrfldnon", 2] call ACEFUNC(common,doAnimation);