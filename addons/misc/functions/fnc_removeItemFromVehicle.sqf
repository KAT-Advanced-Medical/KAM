#include "script_component.hpp"
/*
 * Author: Blue
 * Handle removing item / magazine from vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Item <STRING>
 * 2: Is magazine <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ACE_elasticBandage"] call kat_misc_fnc_removeItemFromVehicle
 *
 * Public: No
 */

params ["_vehicle", "_item", ["_isMagazine", false]];

if !(_isMagazine) then {
    private _cargoItems = getItemCargo _vehicle;

    private _itemIndex = (_cargoItems select 0) findIf {_x isEqualTo _item};

    if (_itemIndex isEqualTo -1) exitWith {};

    clearItemCargoGlobal _vehicle;

    if ((((_cargoItems select 1) select _itemIndex) - 1) < 1) then {
        (_cargoItems select 0) deleteAt _itemIndex;
        (_cargoItems select 1) deleteAt _itemIndex;
    } else {
        (_cargoItems select 1) set [_itemIndex, (((_cargoItems select 1) select _itemIndex) - 1)];
    };

    {
        _vehicle addItemCargoGlobal [((_cargoItems select 0) select _forEachIndex), ((_cargoItems select 1) select _forEachIndex)];
    } forEach (_cargoItems select 0);
} else {
    private _cargoMags = magazinesAmmoCargo _vehicle;

    private _itemIndex = _cargoMags findIf {_x select 0 isEqualTo _item};

    private _magsToAdd = [];

    if (_itemIndex isEqualTo -1) exitWith {};

    clearMagazineCargoGlobal _vehicle;

    {
        if (_forEachIndex isEqualTo _itemIndex) then {
            if (((_x select 1) - 1) > 0) then {
                _magsToAdd append [[_x select 0, ((_x select 1) - 1)]];
            };
        } else {
            _magsToAdd append [[_x select 0, _x select 1]];
        };
    } forEach _cargoMags;

    {                            // name, quantity, ammocount
        _vehicle addMagazineAmmoCargo [_x select 0, 1, _x select 1];
    } forEach (_magsToAdd);
};