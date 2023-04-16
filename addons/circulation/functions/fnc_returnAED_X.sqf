#include "script_component.hpp"
/*
 * Author: Kygan
 * Re-adds the AED X to the player's inventory
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Return <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, true] call kat_circulation_fnc_returnAED_X;
 *
 * Public: No
 */

params ["_medic", "_patient", "_AEDreturn"];
private _output = LLSTRING(X_Action_Remove);

_patient setVariable [QGVAR(X), false, true];
_medic setVariable [QGVAR(AED_X_Volume), _patient getVariable [QGVAR(AED_X_VolumePatient), false], true];

if (_AEDreturn) then {
    _medic setVariable [QGVAR(use), false, true];
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    [_medic, "kat_X_AED"] call ACEFUNC(common,addToInventory);
    _medic setVariable [QGVAR(returnedAED), true, true];
} else {
    _patient setVariable [QGVAR(AEDvehicle), "", true];
    _patient setVariable [QGVAR(vehicleTrue), false, true];
};
