#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handler for airway damage.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airway_fnc_handleAirway;
 *
 * Public: No
 */

params ["_unit"];

//Other mods can utilise KAT_Obstruction_Exclussion variable to prevent obstructions from happening
if !(GVAR(enable)) exitWith {};

if (random(100) < GVAR(probability_obstruction)) then {
    private _level = selectRandom [0, 1];
    private _obstruction = _unit getVariable [QGVAR(obstruction), [0, 0, 0]] select _level;
    _obstruction set [_level, ((_obstruction + 1) min 2)];
    _unit setVariable [QGVAR(obstruction), _obstruction, true];
};
