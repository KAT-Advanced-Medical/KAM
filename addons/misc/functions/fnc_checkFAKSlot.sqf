#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Checks which slots are free to use in an FAK
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "kat_IFAK_Magazine"] call kat_misc_fnc_checkFAKSlot;
 *
 * Public: No
 */

params ["_unit", "_item"];

private _itemType = _item call BIS_fnc_itemType;
private _itemType = _itemType select 0;
private _return = false;

if (_itemType == "Item") exitWith {
	[_unit, _item] call ACEFUNC(common,hasItem);
};

if (_itemType != "Magazine") exitWith {	_return };

switch (_item) do {
	case (_ammoCount >= 1 && _ammoCount <= 8): { };

};


















case (_ammoCount >= 1 && _ammoCount <= 8) :
