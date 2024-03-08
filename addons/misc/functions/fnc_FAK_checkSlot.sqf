#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Blue
 * Checks which slots are free to use in an FAK
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Magazine <STRING>
 * 2: FAK Type <NUMBER>
 * 3: Slot <NUMBER>
 *
 * Return Value:
 * Is usable <BOOLEAN>
 *
 * Example:
 * [player, "kat_IFAK_Magazine", 0, 0] call kat_misc_fnc_FAK_checkSlot;
 *
 * Public: No
 */

params ["_unit", "_item", "_type", "_slot"];

private _itemType = _item call BIS_fnc_itemType;
_itemType = _itemType select 0;

if (_itemType == "Item") exitWith {([_unit, _item] call ACEFUNC(common,hasItem));};

if ((_itemType == "Magazine") && !([_unit, _item] call ACEFUNC(common,hasMagazine)) && {(magazinesAmmoFull [_unit, true]) findIf {_x select 0 isEqualTo _item} isEqualTo -1}) exitWith {false};

private _ammoCount = [_unit, _item] call FUNC(getMagazineAmmoCounts);
private _max = 255;
private _return = false;

switch (_type) do {
    case 0: {_max = 15;}; // IFAK
    case 1: {_max = 63;}; // AFAK
    default {}; // MFAK
};

{
    if (_slot == 0) exitWith {
        _return = true;
        break;
    };

    if (_x >= _max) exitWith {
        _return = true;
        break;
    };
    
    if (([_x, _type] call FUNC(FAK_ammoToArray)) select (_slot - 1)) exitWith {
        _return = true;
        break;
    };
} forEach _ammoCount;

_return;