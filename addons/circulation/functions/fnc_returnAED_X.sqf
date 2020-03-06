#include "script_component.hpp"
/*
 * Author: Kygan
 * Re-adds the AED X to the player's inventory
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_tourniquetRemove
 *
 * Public: No
 */

params ["_player", "_patient"];

_patient setVariable [QGVAR(X), false, true];
_player setVariable [QGVAR(use), false, true];

[_player, "kat_X_AED"] call ace_common_fnc_addToInventory;

true;
