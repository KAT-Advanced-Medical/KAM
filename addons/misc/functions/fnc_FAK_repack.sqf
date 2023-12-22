#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Blue
 * Repacks FAK Slot
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Item <STRING>
 * 2: FAK Type <NUMBER>
 * 3: Slot <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK_Magazine", 0, 1] call kat_misc_fnc_FAK_repack;
 *
 * Public: No
 */

params ["_unit", "_item", "_type", "_slot"];

private _fnc_arrayToRemoveInvItem = {
    params ["_unit", "_array"];

    {
        for "_i" from 1 to (_x select 1) do
        {
            _unit removeItem (_x select 0);
        } 
    } foreach _array;
};

private _fnc_getContainer = {
    params ["_containerType"];

    switch (_containerType) do {
        case 1: {"uniform"};
        case 2: {"vest"};
        case 3: {"backpack"};
        default {""};
    };
};

private _ammoCount = [_unit, _item, true] call FUNC(getMagazineAmmoCounts);
private _slotArray = [];
private _highestAmmoCount = -1;
private _containerFAK = "";

{
    private _checkedArray = [(_x select 0), _type] call FUNC(FAK_ammoToArray);

    if (!(_checkedArray select (_slot - 1)) && (_x select 0) > _highestAmmoCount) then { // Get fullest FAK
        _slotArray = _checkedArray;
        _highestAmmoCount = _x select 0;
        _containerFAK = _x select 1;
    };
} forEach _ammoCount;

if !(_highestAmmoCount > -1) exitWith {};

private _FAKToAdd = "";
private _itemList = [];
private _max = 0;

switch (_type) do {
    case 0: { // IFAK
        _FAKToAdd = "kat_IFAK";
        _itemList = missionNameSpace getVariable [QGVAR(IFAKContents), []];
        _max = 15;
    };
    case 1: { // AFAK
        _FAKToAdd = "kat_AFAK";
        _itemList = missionNameSpace getVariable [QGVAR(AFAKContents), []];
        _max = 63;
    };
    default { // MFAK
        _FAKToAdd = "kat_MFAK";
        _itemList = missionNameSpace getVariable [QGVAR(MFAKContents), []];
        _max = 255;
    };
};

// _unit removeItem _item;
[_unit, _itemList select (_slot - 1)] call _fnc_arrayToRemoveInvItem;

_slotArray set [(_slot - 1), true];

private _amountLeft = [_slotArray] call FUNC(FAK_arrayToAmmo);

if (_amountLeft >= _max) then {

    switch (_containerFAK) do {
        case "Uniform": { 
            uniformContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount]; // We need to use this cause "removeItem" targets the first item with the name it findes.
            [_unit, _FAKToAdd, "uniform"] call ACEFUNC(common,addToInventory); // Ace only accepts "Uniform" when it is in lowercase letters.
        };

        case "Vest": { 
            vestContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount];
            [_unit, _FAKToAdd, "vest"] call ACEFUNC(common,addToInventory);
        };
    
        case "Backpack": { 
            backpackContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount];
            [_unit, _FAKToAdd, "backpack"] call ACEFUNC(common,addToInventory);
        };
    };

} else {

    switch (_containerFAK) do {
        case "Uniform": { 
            uniformContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount];
            uniformContainer _unit addMagazineAmmoCargo [(_FAKToAdd + "_Magazine"), 1, _amountLeft]; // Use this to add the new item in the exact same place where it was before. Also Ace does not support adding a location & ammo count at the same time.
        };

        case "Vest": { 
            vestContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount];
            vestContainer _unit addMagazineAmmoCargo [(_FAKToAdd + "_Magazine"), 1, _amountLeft];
        };
    
        case "Backpack": { 
            backpackContainer _unit addMagazineAmmoCargo [_item, -1, _highestAmmoCount];
            backpackContainer _unit addMagazineAmmoCargo [(_FAKToAdd + "_Magazine"), 1, _amountLeft];
        };
    };
};