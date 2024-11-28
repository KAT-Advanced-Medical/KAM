#include "..\script_component.hpp"
/*
 * Author: apo_tle, from _pharma_fnc_salineCheck
 * Check for any active saline IV
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_patient] call kat_pharma_fnc_findSaline;
 *
 * Public: No
 */

params ["_patient"];

private _fluidCheck = _patient getVariable [QACEGVAR(medical,ivBags), []];
private _check = false;

{
    _x params ["_bagVolumeRemaining", "_type"];

    if (_type isEqualTo "Saline" && _bagVolumeRemaining >= 30) exitWith {
        _check = true;
    };
} forEach _fluidCheck;

if (_check) exitWith {true};

false
