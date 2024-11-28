#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks status of attached oxygen
 * Main function
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_attachVehicleOxygen;
 *
 * Public: No
 */

params ["_vehicle", "_patient"];

if (isNull objectParent _patient) exitWith {
	false
};

private _fullCrew = fullCrew _vehicle;
private _playerPosition = (_fullCrew select {(_x select 0) == _patient}) select 1;

if (_playerPosition isEqualTo "cargo") exitWith {
	false
};

true
