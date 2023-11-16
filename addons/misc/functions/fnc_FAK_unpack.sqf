#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Blue
 * Gives the player the predefined Items (in CBA) for every FAK variant
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: FAK Item <STRING>
 * 2: FAK Type <NUMBER>
 * 3: Slot <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK", 0, 0] call kat_misc_fnc_FAK_unpack;
 *
 * Public: No
 */

params ["_unit", "_item", "_type", "_slot"];

private _fnc_arrayToInvItem = {
    params ["_unit", "_array", "_container"];

    {
        for "_i" from 1 to (_x select 1) do
        {
            [_unit, _x select 0, _container] call ACEFUNC(common,addToInventory);
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

private _itemType = _item call BIS_fnc_itemType;
_itemType = _itemType select 0;

private _container = "";
private _slotArray = [];
private _FAKToAdd = "";
private _itemList = [];
private _removeOnEmptyCondition = false;

switch (_type) do {
    case 0: { // IFAK
        _FAKToAdd = "kat_IFAK_Magazine";
        _slotArray = [true,true,true,true,false,false,false,false];
        _container = [(missionNamespace getVariable [QGVAR(IFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(IFAKContents), []];
        _removeOnEmptyCondition = GVAR(IFAK_RemoveWhenEmpty);
    };
    case 1: { // AFAK
        _FAKToAdd = "kat_AFAK_Magazine";
        _slotArray = [true,true,true,true,true,true,false,false];
        _container = [(missionNamespace getVariable [QGVAR(AFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(AFAKContents), []];
        _removeOnEmptyCondition = GVAR(AFAK_RemoveWhenEmpty);
    };
    default { // MFAK
        _FAKToAdd = "kat_MFAK_Magazine";
        _slotArray = [true,true,true,true,true,true,true,true];
        _container = [(missionNamespace getVariable [QGVAR(MFAK_Container), 0])] call _fnc_getContainer;
        _itemList = missionNameSpace getVariable [QGVAR(MFAKContents), []];
        _removeOnEmptyCondition = GVAR(MFAK_RemoveWhenEmpty);
    };
};

// ----- Handling for full item -----

if (_itemType == "Item") exitWith {
    _unit removeItem _item;
    if (_slot > 0) then {
        _slotArray set [(_slot - 1), false];
        [_unit, (_itemList select (_slot - 1)), _container] call _fnc_arrayToInvItem;

        [_unit, _FAKToAdd, "", ([_slotArray] call FUNC(FAK_arrayToAmmo))] call ACEFUNC(common,addToInventory);
    } else {
        {
            [_unit, _x, _container] call _fnc_arrayToInvItem;
        } forEach _itemList;

        if !(_removeOnEmptyCondition) then {
            [_unit, _FAKToAdd, "", 0] call ACEFUNC(common,addToInventory);
        };
    };
};

// ----- Handling for magazine -----

private _ammoCount = [_unit, _item] call FUNC(getMagazineAmmoCounts);
_unit removeItem _item;
private _lowestAmmoCount = 257;
{
    private _checkedArray = [_x, _type] call FUNC(FAK_ammoToArray);

    if (_x < _lowestAmmoCount && (_slot == 0 || (_slot > 0 && {_checkedArray select (_slot - 1)}))) then { // Get emptiest FAK
        _slotArray = _checkedArray;
        _lowestAmmoCount = _x;
    };
} forEach _ammoCount;

if !(_lowestAmmoCount < 257) exitWith {};

if (_slot > 0) then {
    _slotArray set [(_slot - 1), false];
    [_unit, (_itemList select (_slot - 1)), _container] call _fnc_arrayToInvItem;
    
    private _remaining = [_slotArray] call FUNC(FAK_arrayToAmmo);

    if (_remaining > 0 || !_removeOnEmptyCondition) then {
        [_unit, _FAKToAdd, "", _remaining] call ACEFUNC(common,addToInventory);
    };
} else {
    {
        if (_x) then {
            [_unit, (_itemList select _forEachIndex), _container] call _fnc_arrayToInvItem;
        };
    } forEach _slotArray;

    if !(_removeOnEmptyCondition) then {
        [_unit, _FAKToAdd, "", 0] call ACEFUNC(common,addToInventory);
    };
};