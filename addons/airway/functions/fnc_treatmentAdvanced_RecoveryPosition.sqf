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

params ["_player", "_target"];

if (local _target) then {
    ["treatmentRecoveryPosition", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentRecoveryPosition", [_player, _target], _target] call CBA_fnc_targetEvent;
};

true;