#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the possibility to have dust in the eye.
 *
 * Arguments:
 * 0: Player Object <OBJECT>
 * 1: Framehandler Id <INTEGER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [kat_ophthalmonology_fnc_handleDustInjury, 60, player] call CBA_fnc_addPerFrameHandler;
 *
 * Public: No
 */

params ["_unit", "_pfhID"];

if !(GVAR(enable)) exitWith {};

// check headgear and googles for protection
private _safe = false;

if (headgear _unit != "") then {
    _safe = getNumber (configFile >> "CfgWeapons" >> headgear _unit >> "ACE_Protection") == 1;
};

// if the headgear is not enough to protect, we check the goggles
if (!_safe) then {
    _safe = _unit call ACEFUNC(goggles,isGogglesVisible);
};

// if protected, do nothing
if (_safe) exitWith {};


// get a random integer
private _random = floor(random [0, 50, 100]);

// we only need to set the variables
// pp effect will be added through extra pfh
if (_random <= GVAR(probability_dust_heavy)) exitWith {
    _unit setVariable [QGVAR(dust_injury_heavy), true, true];
};

if (_random <= GVAR(probability_dust)) exitWith {
    _unit setVariable [QGVAR(dust_injury), true, true];
};
