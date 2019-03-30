#include "script_component.hpp"
/*
 * Author: Katalam
 * docks a pulseoximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_acebreathing_fnc_treatmentAdvanced_pulseoximeter;
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
    ["treatmentPulseoximeter", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentPulseoximeter", [_player, _target], _target] call CBA_fnc_targetEvent;
};
