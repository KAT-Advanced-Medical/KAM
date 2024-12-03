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
 * [player] call kat_breathing_fnc_checkPersonalOxygen;
 *
 * Public: No
 */

params ["_patient"];

private _maskStatus = _patient getVariable [QGVAR(oxygenMaskStatus), [0,0]];

if (_maskStatus isEqualTo [0,0]) exitWith {
    [LSTRING(VehicleOxygen_Affirm), 1.5, _patient] call ACEFUNC(common,displayTextStructured);
};

[format ["%1 %2", (_maskStatus select 0), LLSTRING(PersonalOxygen_Remaining)], 1.5, _patient] call ACEFUNC(common,displayTextStructured);