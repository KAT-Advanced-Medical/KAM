#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Update the respiratoryRate effect
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: respiratoryRate Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, 1, false] call kat_vitals_fnc_updaterespiratoryRate
 *
 * Public: No
 */

params ["_unit", "_respiratoryRateAdjustment", "_deltaT", "_syncValue"];

_unit setVariable [QEGVAR(pharma,respiratoryRate), _respiratoryRateAdjustment, _syncValue];
