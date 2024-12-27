#include "..\script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, commy2
 * Handles explosions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Function is handled? <BOOL>
 *
 * Example:
 * [bob] call ace_goggles_fnc_handleExplosion
 *
 * Public: No
 */

params ["_unit"];

if (_unit != ACE_player) exitWith {};

if (_random < GVAR(probability_dust_heavy)) exitWith {

    // Get the current state of the eyes (defaulting to healthy if not set)
    private _eyeInjuries = _unit getVariable [QGVAR(eyeInjuries), [1, 1]];

    // Randomly choose which eye to injure (0 = left, 1 = right)
    private _injuredEye = floor random 2;

    // Set the chosen eye to injured
    _eyeInjuries set [_injuredEye, 0];

    _unit setVariable [QGVAR(eyeInjuries), _eyeInjuries, true];
};
