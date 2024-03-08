#include "..\script_component.hpp"
/*
 * Author: mharis001, Blue
 * Returns list of unique items in the target's inventory.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Target is vehicle <BOOL>
 * 2: Check for magazines <BOOL>
 *
 * Return Value:
 * Items <ARRAY>
 *
 * Example:
 * [player, false, true] call kat_misc_fnc_getUniqueItems
 *
 * Public: No
 */

params ["_target", ["_isVehicle",false], ["_checkMagazine",false]];

private _fnc_getItems = {
    private _items = [];

    if !(_isVehicle) then {
        private _inventoryItems = [];

        _inventoryItems append ((getItemCargo uniformContainer _target) select 0);
        _inventoryItems append ((getItemCargo vestContainer _target) select 0);
        _inventoryItems append ((getItemCargo backpackContainer _target) select 0);

        _items set [0, _inventoryItems];
        _items set [1, (magazines _target)];
    } else {
        if (_checkMagazine) then {
            _items append (magazineCargo _target);
        } else {
            _items append (itemCargo _target);
        };
    };

    _items arrayIntersect _items
};

// Cache items list if unit is ACE_player
if (_target isEqualTo ACE_player) then {
    if (isNil QGVAR(uniqueItemsCache)) then {
        GVAR(uniqueItemsCache) = call _fnc_getItems;
    };

    if(_checkMagazine) then {
        GVAR(uniqueItemsCache) select 1;
    } else {
        GVAR(uniqueItemsCache) select 0;
    };
} else {
    if (_isVehicle) then {
        call _fnc_getItems;
    } else {
        if(_checkMagazine) then {
            (call _fnc_getItems) select 1;
        } else {
            (call _fnc_getItems) select 0;
        };
    };
};
