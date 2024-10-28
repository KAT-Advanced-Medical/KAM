#include "..\script_component.hpp"
/*
 * Author: Glowbal, modified by Cplhardcore
 * Update the opioid relief effect
 *
 * Arguments:
 * 0: The Unit <OBJECT> 
 * 1: Opioid Relief Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updateOpioidRelief
 *
 * Public: No
 */

params ["_unit", "_opioidAdjustment", "_deltaT", "_syncValue"];
_unit setVariable [QEGVAR(pharma,opioidFactor), _opioidAdjustment, _syncValue];


