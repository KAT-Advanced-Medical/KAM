#include "script_component.hpp"
/*
 * Author: Blue
 * Handles detaching AED-X monitor from patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: AED-X origin <INT>
 *    0: Medic
 *    1: Placed
 *    2: Vehicle
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 0] call kat_circulation_fnc_detachAEDX;
 *
 * Public: No
 */

params ["_medic", "_patient",["_AEDOrigin",0]];

_patient setVariable [QGVAR(X), false, true];

switch (_AEDOrigin) do {
    case 1: {
        [LLSTRING(X_Action_Remove), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        private _placedAEDX = _patient getVariable QGVAR(AED_X_Provider);
        _placedAEDX setVariable [QGVAR(AED_X_Connected), false, true];
        _placedAEDX setVariable [QGVAR(AEDinUse), false, true];
        _placedAEDX setVariable [QGVAR(AED_X_Volume), _patient getVariable [QGVAR(AED_X_VolumePatient), false], true];
        _placedAED setVariable [QGVAR(AED_X_Patient), nil, true];
        _patient setVariable [QGVAR(AED_X_Provider), nil, true];
    };
    case 2: {
        [LLSTRING(X_Action_Remove), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        _medic setVariable [QGVAR(AED_X_Volume), _patient getVariable [QGVAR(AED_X_VolumePatient), false], true];
        _patient setVariable [QGVAR(AED_X_Provider), nil, true];
    };
    default {
        [LLSTRING(X_Action_Remove), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        _medic setVariable [QGVAR(AED_X_Connected), false, true];
        _medic setVariable [QGVAR(AED_X_Volume), _patient getVariable [QGVAR(AED_X_VolumePatient), false], true];
    };
};