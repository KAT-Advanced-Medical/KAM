#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Checks Saline volume remaining
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_medic, _patient] call kat_pharma_fnc_salineCheck;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _fluidCheck = _patient getVariable ["ace_medical_ivBags", []];
private _check = false;

{
    _x params ["_bagVolumeRemaining", "_type"];

    if (_type isEqualTo "Saline" && _bagVolumeRemaining >= 30) exitWith {
        _check = true;
    };
} forEach _fluidCheck;

if (_check) exitWith {true};

false
