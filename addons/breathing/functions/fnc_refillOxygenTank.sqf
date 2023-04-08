#include "script_component.hpp"
/*
 * Author: Blue
 * Refill unit's portable oxygen tank
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Oxygen Tank <STRING>
 * 2: Time to refill <NUMBER>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [player,"kat_oxygenTank_150",5] call kat_breathing_fnc_refillOxygenTank;
 *
 * Public: No
 */

params ["_unit","_tank","_refillTime"];
_unit removeItem [_tank,"Empty"] joinString "_";
[_unit, "PutDown"] call EFUNC(common,doGesture);
[_refillTime, ["_unit","_tank"], 
{
    _unit addMagazine _tank;
    [_unit, "PutDown"] call EFUNC(common,doGesture);
}, 
{
    _unit addItem [_tank,"Empty"] joinString "_";
}, 
"Refilling Portable Oxygen Tank",
{
    _tank in (items _unit);
}] call ACEFUNC(common,progressBar);