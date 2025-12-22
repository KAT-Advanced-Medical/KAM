#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Calculate stroke volume of a single heart beat.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 *    stroke volume (l) <NUMBER>
 *
 * Example:
 * [player] call kat_vitals_fnc_getCushings
 *
 * Public: No
 */

params ["_unit"];

private _icp = GET_ICP(_unit);
private _map = GET_MAP(_unit);
private _cpp = (_map - _icp) max 0;

// Only meaningful when ICP is high AND CPP threatened
if (_icp < 20) exitWith {0};

// ICP driven severity
private _icpFactor = linearConversion [20, 45, _icp, 0, 1, true];

// CPP driven severity (low CPP = worse)
private _cppFactor = linearConversion [70, 30, _cpp, 0, 1, true];

// Combined severity
(_icpFactor max _cppFactor)