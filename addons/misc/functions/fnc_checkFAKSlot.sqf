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

if (_itemType == "Item") then {
	if ([_unit, _item] call ACEFUNC(common,hasItem)) exitWith { };
} else {
	[_unit, _item] call ACEFUNC(common,hasMagazine);
};

return = false;