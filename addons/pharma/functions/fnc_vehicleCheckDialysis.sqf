#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Allows for dialysis to occur around medical vehicles
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_surgery_fnc_vehicleCheckDialysis
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _checkArray = _patient nearEntities 10;
private _return = false;

{
    if (_x getVariable [QACEGVAR(medical,isMedicalVehicle), false]) exitWith {
        _return = true;
    };
} forEach _checkArray;

_return
