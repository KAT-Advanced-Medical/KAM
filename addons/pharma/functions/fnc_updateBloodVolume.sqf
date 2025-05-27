#include "..\script_component.hpp"
/*
 * Author: LinkIsGrim
 * Update unit blood volume
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 5, false] call ace_medical_vitals_fnc_updateBloodVolume
 *
 * Public: No
 */
params ["_unit", "_deltaT", "_syncValues"];

