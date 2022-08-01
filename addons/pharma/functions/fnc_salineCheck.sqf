#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_circulation_fnc_applyIV;
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
