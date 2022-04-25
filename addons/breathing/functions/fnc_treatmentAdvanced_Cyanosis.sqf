#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks the cyanosis level of the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_checkCyanosis
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
    ["treatmentCyanosis", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentCyanosis", [_player, _target], _target] call CBA_fnc_targetEvent;
};

true;