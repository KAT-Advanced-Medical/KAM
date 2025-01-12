#include "..\script_component.hpp"
/*
 * Author: Ruthberg
 * Check if a unit can be converted back into resources
 *
 * Arguments:
 * 0: The patient <OBJECT>
 *
 * Return Value:
 * Has stable vitals <BOOL>
 *
 * Example:
 * [player] call kat_conversion_conversionCondition
 *
 * Public: No
 */

params ["_unit"];

private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_unit);
if (_bloodVolume < ACEGVAR(medical,const_stableVitalsBloodThreshold)) exitWith { false };

if IN_CRDC_ARRST(_unit) exitWith { false };

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 50 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
if (_heartRate < 70 || _heartRate > 100) exitWith { false };

private _o2 = GET_KAT_SPO2(_unit);
if (_o2 < EGVAR(breathing,Stable_spo2)) exitWith { false };

private _fractures = _unit getVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0]];
if (({_x == 0} count _fracture) != 6) exitWith { false };

true