#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a pulseoximeter for a patient and adds Item to the caller
 *
 * Arguments:
 * 0: medic <OBJECT>
 * 1: patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_removePulseoximeter;
 *
 * Public: No
 */

params ["_player", "_target"];

_target setVariable [QGVAR(pulseoximeter), false, true];

if (_player canAdd "kat_Pulseoximeter") then {
    _player addItem "kat_Pulseoximeter";
} else {
    private _groundHolder = createVehicle ["WeaponHolderSimulated", _target, [], 0.5, "CAN_COLLIDE"];
    _groundHolder addItemCargoGlobal ["kat_Pulseoximeter", 1];
};
