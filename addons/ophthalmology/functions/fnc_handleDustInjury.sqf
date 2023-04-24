#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the possibility to have dust in the eye.
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player", "_pfhID"];

if !(GVAR(enable)) exitWith {};

// check headgear and googles for protection
private _safe = false;

if (headgear _unit != "") then {
    _safe = getNumber (configFile >> "CfgWeapons" >> headgear _unit >> "ACE_Protection") == 1;
};

// if the headgear is not enough to protect, we check the goggles
if (!_safe) then {
    _safe = _player call ACEFUNC(goggles,isGogglesVisible);
};

// if protected, do nothing
if (_safe) exitWith {};


// get a random integer
private _random = floor(random [0, 50, 100]);

// we only need to set the variables
// pp effect will be added through extra pfh
if (_random <= GVAR(probability_dust_heavy)) exitWith {
    _player setVariable [QGVAR(dust_injury_heavy), true, true];
};

if (_random <= GVAR(probability_dust)) exitWith {
    _player setVariable [QGVAR(dust_injury), true, true];
};
