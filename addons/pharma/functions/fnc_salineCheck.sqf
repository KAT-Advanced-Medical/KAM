#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Checks Saline volume remaining
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
 * [_medic, _patient, "RightArm"] call kat_pharma_fnc_salineCheck;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
if (_IVactual != 3) exitWith {false};

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
