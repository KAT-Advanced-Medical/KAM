#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Update the opioid effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Opioid Effect Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updateOpioidEffect
 *
 * Public: No
 */

params ["_unit", "_opioidEffectAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [VAR_PP, 0 max _opioidEffectAdjustment, _syncValue];

