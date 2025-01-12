#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Converts patient to Liberation Supply
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_libConversion
 *
 * Public: No
 */

params ["_patient"];

private _storageAreas = (([_patient] call KPLIB_fnc_getNearestFob) nearobjects (GRLIB_fob_range)) select {(_x getVariable ["KP_liberation_storage_type",-1]) == 0};
private _crate = [KP_liberation_supplyCrate, GVAR(enableLiberationConversionGain), [[getPos _patient] select 0, [getPos _patient] select 1, 10000]];

{
    if ([_crate, _storage] call KPLIB_fnc_crateToStorage) then { break };
} forEach _storageAreas;

_patient setDamage 1; 
deleteVehicle _patient;