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
if ( !(GVAR(enable)) || (_unit getVariable ["KAT_Obstruction_Exclussion", false])) exitWith {};

private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];

if (!_isUnconscious || (_unit getVariable [QGVAR(airway_item), ""] in ["Larynxtubus","Guedeltubus"])) exitWith {
    _unit setVariable [QGVAR(obstruction), false, true];
};

if (random(100) < GVAR(probability_obstruction)) then {
    _unit setVariable [QGVAR(obstruction), true, true];
};
