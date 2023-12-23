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

        [_unit, _FAKToAdd, "", ([_slotArray] call FUNC(FAK_arrayToAmmo))] call ACEFUNC(common,addToInventory);

        [_unit, (_itemList select (_slot - 1)), _container] call _fnc_arrayToInvItem;
    } else {
        if !(_removeOnEmptyCondition) then {
            [_unit, _FAKToAdd, "", 0] call ACEFUNC(common,addToInventory);
        };

        {
            [_unit, _x, _container] call _fnc_arrayToInvItem;
        } forEach _itemList;
    };
};

// ----- Handling for magazine -----

private _ammoCount = [_unit, _item, true] call FUNC(getMagazineAmmoCounts);
private _lowestAmmoCount = 257;
private _containerFAK = "";
{
    private _checkedArray = [(_x select 0), _type] call FUNC(FAK_ammoToArray);

    if ((_x select 0) < _lowestAmmoCount && (_slot == 0 || (_slot > 0 && {_checkedArray select (_slot - 1)}))) then { // Get emptiest FAK
        _slotArray = _checkedArray;
        _lowestAmmoCount = _x select 0;
        _containerFAK = _x select 1;
    };
} forEach _ammoCount;

if !(_lowestAmmoCount < 257) exitWith {};

if (_slot > 0) then {
    _slotArray set [(_slot - 1), false];
    
    private _remaining = [_slotArray] call FUNC(FAK_arrayToAmmo);

    if (_remaining > 0 || !_removeOnEmptyCondition) then {
        switch (_containerFAK) do {
            case "Uniform": { 
                uniformContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount]; // We need to use this cause "removeItem" targets the first item with the name it findes.
                uniformContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, _remaining]; // We are using this to place the new FAK in the same container as the old one.
            };

            case "Vest": { 
                vestContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];
                vestContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, _remaining];
            };

            case "Backpack": { 
                backpackContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];
                backpackContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, _remaining];
            };
        };
    };

    [_unit, (_itemList select (_slot - 1)), _container] call _fnc_arrayToInvItem;
} else {

    switch (_containerFAK) do { // Remove switch for the correct FAK "removeItem" always uses the first one not always the correct / selected one.
        case "Uniform": { 
            uniformContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];
        };

        case "Vest": { 
            vestContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];
        };

        case "Backpack": { 
            backpackContainer _unit addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];
        };
    };

    if !(_removeOnEmptyCondition) then {
        switch (_containerFAK) do { // We need this switch to add the empty FAK in the same container as old one. 
            case "Uniform": { 
                uniformContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, 0]; 
            };

            case "Vest": { 
                vestContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, 0];
            };

            case "Backpack": { 
                backpackContainer _unit addMagazineAmmoCargo [_FAKToAdd, 1, 0];
            };
        };
    };

    {
        if (_x) then {
            [_unit, (_itemList select _forEachIndex), _container] call _fnc_arrayToInvItem;
        };
    } forEach _slotArray;
};