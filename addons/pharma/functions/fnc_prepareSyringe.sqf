#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a syringe and a given medication and
 * returns a "crafted" syringe with fluid 
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Player <NUMBER>
 * 2: Params <ARRAY>
 *  0: Class name of medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player, []] call kat_pharma_fnc_prepareSyringe;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_className"];

private _hasSyringe = isClass (configFile >> "CfgWeapons" >> format [_className + "Syringe"]);

if (!_hasSyringe) exitWith {};

_player removeItem "kat_syringe";
_player removeItem _className;
_player addItem (_className + "Syringe");
