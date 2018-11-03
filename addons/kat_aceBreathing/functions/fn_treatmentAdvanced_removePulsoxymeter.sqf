/*
 * Author: Katalam
 * Removes a pulsoxymeter for a patient and adds Item to the caller
 *
 * Arguments:
 * 0: medic <OBJECT>
 * 1: patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceBreathing_fnc_treatmentAdvanced_removePulsoxymeter;
 *
 * Public: No
 */

params ["_player", "_target"];

_target setVariable ["kat_aceBreathing_pulsoxymeter", false, true];

if (_player canAdd "KAT_Pulsoxymeter") then {
  _player addItem "KAT_Pulsoxymeter";
} else {
  private _groundHolder = createVehicle ["WeaponHolderSimulated", _target, [], 0.5, "CAN_COLLIDE"];
  _groundHolder addItemCargoGlobal ["KAT_Pulsoxymeter", 1];
};
