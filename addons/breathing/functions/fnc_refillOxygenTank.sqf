#include "script_component.hpp"
/*
 * Author: Blue
 * Refill unit's portable oxygen tank
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_refillOxygenTank;
 *
 * Public: No
 */

params ["_unit","_tank"];

_unit removeItem [_tank,"Empty"] joinString "_";
_unit addMagazine _tank;