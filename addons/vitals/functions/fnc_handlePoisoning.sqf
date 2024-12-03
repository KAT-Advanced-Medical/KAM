#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Update poisoning

 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Poison Adjustments <NUMBER>
 * 2: Time since last update <NUMBER>
 * 3: Sync value? <BOOL>
 *
 * ReturnValue:
 * None
 *
 * Example:
 * [player, 1, 1, false] call kat_vitals_handlePoisoning;
 *
 * Public: No
 */

params ["_unit", "_poisonAdjustment", "_deltaT", "_syncValue"];

private _currentCS = _unit getVariable [QEGVAR(chemical,CSGas), 0];

_unit setVariable [QEGVAR(chemical,CSGas), (_currentCS - (_poisonAdjustment * _deltaT)) max 0, _syncValue];
