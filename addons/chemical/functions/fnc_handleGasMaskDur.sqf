#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_handleGasMaskDur;
 *
 * Public: No
*/

params ["_unit"];

if !(goggles _unit in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitWith {};

// Get the maximum time the gas mask filter can last (from settings)
private _maxTime = missionNamespace getVariable [QGVAR(gasmask_durability), 60]; // Max durability in seconds

// Get the current health (0-10) of the gas mask filter for this unit
private _currentHealth = _unit getVariable [QGVAR(gasmask_durability), 10]; // Default to full health (10) if not set

// Scale the current health (0-10) to the actual time left based on maxTime
private _timeLeft = (_currentHealth / 10) * _maxTime; // Convert 0-10 health scale to time left

// Reduce the time left by 1 seconds (each tick reduces by 1 seconds)
_timeLeft = _timeLeft - 1;

// Prevent negative durability
_timeLeft = _timeLeft max 0;

// Convert the remaining time back to the 0-10 health scale
private _newHealth = (_timeLeft / _maxTime) * 10;

// Calculate percentage of health remaining
private _percent = (_newHealth / 10) * 100;

// Exit if the gas mask health reaches 0 or the unit is dead
if (_newHealth <= 0) exitWith {
    _unit setVariable [QGVAR(gasmask_durability), 0, true];
};

// Update the gas mask health if it has changed
if (_currentHealth != _newHealth) then {
    _unit setVariable [QGVAR(gasmask_durability), _newHealth, true];
};
