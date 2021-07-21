#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Checks for AED-Xs in vehicle inventories and allows them to be used on patients both in and around the vehicle.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Vehicle has Device <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_vehicleCheck;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _return = false;
private _checkArray = _patient nearEntities 5;
private _inventory = [];

{
    _inventory = itemCargo _x;

    if (_x isKindOf "LandVehicle" || _x isKindOf "Helicopter") then {
	    {
			if (_x == "kat_X_AED") then {
				_return = true;
			};
		} forEach _inventory;
	};
} forEach _checkArray;

_return