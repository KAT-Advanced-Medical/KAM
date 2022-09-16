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

if (local _patient) then {
    ["treatmentCancelRecoveryPosition", [_medic, _patient]] call CBA_fnc_localEvent;
} else {
    ["treatmentCancelRecoveryPosition", [_medic, _patient], _patient] call CBA_fnc_targetEvent;
};

true;