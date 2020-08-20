#include "script_component.hpp"
/*
 * Author: Kygan
 * Treatment for hemopneumothorax
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
 * call kat_breathing_fnc_treatmentAdvanced_hemopneumothorax;
 *
 * Public: No
 */

params ["_player", "_target"];
systemChat "Treating Hemopneumothorax";
if (local _target) then {
    ["treatmentHemopneumothorax", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentHemopneumothorax", [_player, _target], _target] call CBA_fnc_targetEvent;
};
