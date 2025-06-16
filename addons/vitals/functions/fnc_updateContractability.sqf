#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Update the contractility effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: contractility Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updatecontractility
 *
 * Public: No
 */

params ["_unit", "_contractilityAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [QEGVAR(pharma,heartContractility), _contractilityAdjustment, _syncValue];
