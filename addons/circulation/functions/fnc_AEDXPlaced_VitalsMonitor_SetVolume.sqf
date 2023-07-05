#include "script_component.hpp"
/*
 * Author: Blue
 * Handle setting vitals monitor volume for placed AED-X.
 *
 * Arguments:
 * 0: Placed AED-X <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call kat_circulation_fnc_AEDXPlaced_VitalsMonitor_SetVolume
 *
 * Public: No
 */

params ["_source", "_volume"];

private _patient = _source getVariable [QGVAR(AED_X_VitalsMonitor_Patient), objNull];

if (isNull _patient) then {
    _patient = _source getVariable [QGVAR(Defibrillator_Patient), objNull];
};

if (isNull _patient) exitWith {};

_patient setVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), _volume, true];