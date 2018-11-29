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
 * call kat_aceBreathing_fnc_treatmentAdvanced_removePulseoximeter;
 *
 * Public: No
 */

params ["_player", "_target"];

_target setVariable ["kat_aceBreathing_pulseoximeter", false, true];

if (_player canAdd "KAT_Pulseoximeter") then {
  _player addItem "KAT_Pulseoximeter";
} else {
  private _groundHolder = createVehicle ["WeaponHolderSimulated", _target, [], 0.5, "CAN_COLLIDE"];
  _groundHolder addItemCargoGlobal ["KAT_Pulseoximeter", 1];
};
