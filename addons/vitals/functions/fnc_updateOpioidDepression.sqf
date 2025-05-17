#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Update the opioid Depression effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Opioid Depression Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updateOpioidDepression
 *
 * Public: No
 */

params ["_unit", "_opioidDepressionAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [QEGVAR(pharma,opioidDepression), _opioidDepressionAdjustment, _syncValue];
