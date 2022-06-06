#include "script_component.hpp"
/*
 * Author: Ruthberg
 * Check if a unit has stable vitals (required to become conscious)
 *
 * Arguments:
 * 0: The patient <OBJECT>
 *
 * Return Value:
 * Has stable vitals <BOOL>
 *
 * Example:
 * [player] call ace_medical_status_fnc_hasStableVitals
 *
 * Public: No
 */

params ["_unit"];

if IN_CRDC_ARRST(_unit) exitWith { false };
if (_unit getVariable [QGVAR(sedated), false]) exitWith { false };

private _bloodVolume = GET_BLOOD_VOLUME(_unit);
if (_bloodVolume < 5.1) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
if (_heartRate < 40) exitWith { false };

true
