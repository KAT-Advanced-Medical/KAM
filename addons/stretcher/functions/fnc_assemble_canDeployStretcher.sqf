#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if the player can deploy the stretcher.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Can deploy <BOOL>
 *
 * Example:
 * [player] call kat_stretcher_fnc_assemble_canDeployStretcher;
 *
 * Public: No
 */

params ["_player"];

private _secondaryWeapon = secondaryWeapon _player;

_secondaryWeapon != "" && {getText (configFile >> "CfgWeapons" >> _secondaryWeapon >> QUOTE(ADDON) >> "type") == "placeable"} // return
