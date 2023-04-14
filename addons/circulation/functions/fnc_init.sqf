#include "script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_init;
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(X), false, true];
_unit setVariable [QGVAR(AED_X_Volume), true, true];
_unit setVariable [QGVAR(AED_X_VolumePatient), false, true];
_unit setVariable [QGVAR(use), false, true];
_unit setVariable [QGVAR(returnedAED), false, true];
_unit setVariable [QGVAR(asystole), 1, true];
_unit setVariable [QGVAR(CPRcount), 2, true];
_unit setVariable [QGVAR(AEDinUse), false, true];
_unit setVariable [QGVAR(soundPlayed), false, true];

_unit setVariable [QGVAR(AEDvehicleName), "", true];
_unit setVariable [QGVAR(vehicleTrue), false, true];
_unit setVariable [QGVAR(AEDvehicle), false, true];