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
 * [player] call kat_breathing_fnc_checkAircraftOxygen;
 *
 * Public: No
 */

params ["_patient"];

if (isNull objectParent _patient) exitWith {
    false
};

private _playerPosition = assignedVehicleRole _patient;

if ((_playerPosition select 0) isEqualTo "cargo") exitWith {
    false
};

true