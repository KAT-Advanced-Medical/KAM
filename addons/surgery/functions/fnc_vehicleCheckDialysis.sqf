#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Checks for AED-Xs in vehicle inventories and allows them to be used on patients both in and around the vehicle.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_applyIV;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _checkArray = _patient nearEntities 10;
private _return = false;

{
    if (_x getVariable ["ace_medical_isMedicalVehicle", false]) exitWith {
        _return = true;
    };
} forEach _checkArray;

_return