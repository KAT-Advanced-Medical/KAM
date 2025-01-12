#include "..\script_component.hpp"
/*
 * Author: mharis001
 * Condition for going into cardiac arrest upon receiving a fatal injury.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_conditionSecondChance
 *
 * Public: No
 */

params ["_this"];

private _storageAreas = (([_this] call KPLIB_fnc_getNearestFob) nearobjects (GRLIB_fob_range)) select {(_x getVariable ["KP_liberation_storage_type",-1]) == 0};
private _crate = [KP_liberation_supplyCrate, 100, [[getPos _this] select 0, [getPos _this] select 1, 10000]];

{
    if ([_crate, _storage] call KPLIB_fnc_crateToStorage) then { break };
} forEach _storageAreas;