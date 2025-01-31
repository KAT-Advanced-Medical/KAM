#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks blood volume protected by REBOA
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call kat_surgery_fnc_reboaVolume
 *
 * Public: No
 */

params ["_patient"];

private _reboa = _patient getVariable [QGVAR(reboa), false];
private _tourniquets = GET_TOURNIQUETS(_patient);
private _volume = 0;

if (_reboa) then { _volume = _volume + 1.2; };
if ((_tourniquets select 1) != 0) then { _volume = _volume + 0.3; };

_volume
