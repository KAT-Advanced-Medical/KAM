#include "..\script_component.hpp"
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

params ["_unit"];

if !(GVAR(enable)) exitWith {};

// get a random integer
private _random = floor(random [0, 50, 100]);

if (_random <= GVAR(probability_dust_heavy)) exitWith {
    _unit setVariable [QGVAR(dust_injury_heavy), true, true];
    [_unit] call FUNC(handleDustInjuryEffects);
};

if (_random <= GVAR(probability_dust)) exitWith {
    _unit setVariable [QGVAR(dust_injury), true, true];
    [_unit] call FUNC(handleDustInjuryEffects);
};
