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

private _ammoCount = [_unit, _item] call FUNC(getMagazineAmmoCounts);
private _slotArray = [];
private _highestAmmoCount = -1;

{
    private _checkedArray = [_x, _type] call FUNC(FAK_ammoToArray);

    if (!(_checkedArray select (_slot - 1)) && _x > _highestAmmoCount) then { // Get fullest FAK
        _slotArray = _checkedArray;
        _highestAmmoCount = _x;
    };
} forEach _ammoCount;

if !(_highestAmmoCount > -1) exitWith {};

private _container = "";
private _FAKToAdd = "";
private _itemList = [];
private _max = 0;

switch (_type) do {
    case 0: { // IFAK
        _FAKToAdd = "kat_IFAK";
        _container = [(missionNamespace getVariable [QGVAR(IFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(IFAKContents), []];
        _max = 15;
    };
    case 1: { // AFAK
        _FAKToAdd = "kat_AFAK";
        _container = [(missionNamespace getVariable [QGVAR(AFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(AFAKContents), []];
        _max = 63;
    };
    default { // MFAK
        _FAKToAdd = "kat_MFAK";
        _container = [(missionNamespace getVariable [QGVAR(MFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(MFAKContents), []];
        _max = 255;
    };
};

_unit removeItem _item;
[_unit, _itemList select (_slot - 1)] call _fnc_arrayToRemoveInvItem;

_slotArray set [(_slot - 1), true];

private _amountLeft = [_slotArray] call FUNC(FAK_arrayToAmmo);

if (_amountLeft >= _max) then {
    [_unit, _FAKToAdd, _container] call ACEFUNC(common,addToInventory);
} else {
    [_unit, (_FAKToAdd + "_Magazine"), _container, _amountLeft] call ACEFUNC(common,addToInventory);
};