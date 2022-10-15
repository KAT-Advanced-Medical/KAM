#include "script_component.hpp"
/*
 * Author: Ruthberg
 * Edit: YetheSamartaka (corrections by Tomcat) - added condition for Spo2 values
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

if ((_unit getVariable ["ace_medical_bloodVolume", 6.0]) < 5.1) exitWith { false };
if (_unit getVariable ["ace_medical_inCardiacArrest", false]) exitWith { false };
if (_unit getVariable ["kat_pharma_sedated", false]) exitWith { false };

private _bloodPressure = [_unit] call ace_medical_status_fnc_getBloodPressure;
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 50 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = _unit getVariable ["ace_medical_heartRate", 80];
if (_heartRate < 40) exitWith { false };

//KAT Breathing - condition for Spo2 value
private _o2 = _unit getVariable ["KAT_medical_airwayStatus", 100];
if (_o2 < GVAR(Stable_spo2)) exitWith { false };

true
