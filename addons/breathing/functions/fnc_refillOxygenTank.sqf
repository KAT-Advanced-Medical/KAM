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

private _emptyTank = [_tank,"Empty"] joinString "_";

_unit removeItem _emptyTank;

[_refillTime, [_unit,_tank,_emptyTank], 
{
    params["_args"];
    _args params ["_unit","_tank"];

    _unit addMagazine _tank;
    [LLSTRING(RefillPortableOxygenTank_Complete), 1.5, _unit] call ACEFUNC(common,displayTextStructured);
}, 
{
    params["_args"];
    _args params ["_unit","_emptyTank"];

    _unit addItem _emptyTank;
    [LLSTRING(RefillPortableOxygenTank_Cancel), 1.5, _unit] call ACEFUNC(common,displayTextStructured);
}, 
LLSTRING(RefillPortableOxygenTank_Progress)] call ACEFUNC(common,progressBar);