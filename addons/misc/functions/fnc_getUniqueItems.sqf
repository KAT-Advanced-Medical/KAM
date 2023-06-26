#include "script_component.hpp"
/*
 * Author: Blue
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

private _items = [];

if !(_isVehicle) then {
    if(_checkMagazine) then {
        _items append (magazines _target);
    } else {
        _items append ((getItemCargo uniformContainer _target) select 0);
        _items append ((getItemCargo vestContainer _target) select 0);
        _items append ((getItemCargo backpackContainer _target) select 0);
    };
} else {
    if (_checkMagazine) then {
        _items append (magazineCargo _target);
    } else {
        _items append (itemCargo _target);
    };
};

_items arrayIntersect _items