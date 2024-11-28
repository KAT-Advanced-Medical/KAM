#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Attaches vehicle oxygen to player
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

params ["_patient"];

if (_patient getVariable [QGVAR(oxygenMaskActive), false]) exitWith {
    [LSTRING(PersonalOxygen_Affirm), 1.5, _patient] call ACEFUNC(common,displayTextStructured);
};

_patient setVariable [QGVAR(oxygenMaskActive), true, true];

[{ isNull objectParent _patient }, {
    _patient setVariable [QGVAR(oxygenMaskActive), false, true];
}, _patient, -1] call CBA_fnc_waitUntilAndExecute;