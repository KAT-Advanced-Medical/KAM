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

    private _groundContainer = nearestObjects [_unit, ["GroundWeaponHolder", "WeaponHolder", "Library_WeaponHolder", "WeaponHolderSimulated"], 2] param [0];

    {
        for "_i" from 1 to (_x select 1) do
        {
            private _inventory = [_unit, _x select 0, _container] call ACEFUNC(common,addToInventory);

            if !(_inventory select 0) then {
                if (isNil "_groundContainer") exitWith {
                    _groundContainer = _inventory select 1;
                };

                {
                    _groundContainer addItemCargoGlobal [_x, 1];
                } forEach itemCargo (_inventory select 1);

                deleteVehicle (_inventory select 1);
            };
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

private _fnc_getUnitContainer = {
    params ["_container", "_unit"];

    switch (_container) do {
        case "Uniform": { uniformContainer _unit};
        case "Vest": { vestContainer _unit};
        case "Backpack": { backpackContainer _unit};
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

private _unitContainer = [_containerFAK, _unit] call _fnc_getUnitContainer;

_unitContainer addMagazineAmmoCargo [_item, -1, _lowestAmmoCount];

if (_slot > 0) then {
    _slotArray set [(_slot - 1), false];
    
    private _remaining = [_slotArray] call FUNC(FAK_arrayToAmmo);

    if (_remaining > 0 || !_removeOnEmptyCondition) then {
        _unitContainer addMagazineAmmoCargo [_FAKToAdd, 1, _remaining];
    };

    [_unit, (_itemList select (_slot - 1)), _container] call _fnc_arrayToInvItem;
} else {
    if !(_removeOnEmptyCondition) then {
        _unitContainer addMagazineAmmoCargo [_FAKToAdd, 1, 0];
    };

    {
        if (_x) then {
            [_unit, (_itemList select _forEachIndex), _container] call _fnc_arrayToInvItem;
        };
    } forEach _slotArray;
};
