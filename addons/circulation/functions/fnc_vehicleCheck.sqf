#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Checks for AED-Xs in vehicle inventories and allows them to be used on patients both in and around the vehicle.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_vehicleCheck;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = false;
private _checkArray = _patient nearEntities 10;
private _inventory = [];

{
    _inventory = itemCargo _x;

    if (_x isKindOf "LandVehicle" || _x isKindOf "Helicopter") then {
        {
            if (_x isEqualTo "kat_X_AED") then {
                _return = true;
            };
        } forEach _inventory;

        if (_return) then {
            _patient setVariable [QGVAR(AEDvehicleName), _x, true];
            _patient setVariable [QGVAR(vehicleTrue), true, true];
        };
    };
} forEach _checkArray;

_return
