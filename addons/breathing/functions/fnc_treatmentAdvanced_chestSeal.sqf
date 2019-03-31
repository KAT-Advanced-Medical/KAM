#include "script_component.hpp"
/*
 * Author: Katalam
 * Treatment for a pulmo injury
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
 * call kat_breathing_fnc_treatmentAdvanced_chestSeal;
 *
 * Public: No
 */

params ["_player", "_target"];

if (local _target) then {
    ["treatmentChestSeal", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentChestSeal", [_player, _target], _target] call CBA_fnc_targetEvent;
};
