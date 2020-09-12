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
 * call kat_breathing_fnc_treatmentAdvanced_tensionpneumothorax;
 *
 * Public: No
 */

params ["_player", "_target"];
// systemChat "Treating Hemopneumothorax";
if (local _target) then {
    ["treatmentTensionpneumothorax", [_player, _target]] call CBA_fnc_localEvent;
} else {
    ["treatmentTensionpneumothorax", [_player, _target], _target] call CBA_fnc_targetEvent;
};
