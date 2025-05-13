#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Update the respiratoryRate effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: respiratoryDepth Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updaterespiratoryDepth
 *
 * Public: No
 */

params ["_unit", "_respiratoryDepthAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [QEGVAR(pharma,respiratoryDepth), _respiratoryDepthAdjustment, _syncValue];
