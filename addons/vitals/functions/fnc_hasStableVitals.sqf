#include "..\script_component.hpp"
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

private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_unit);
if (_bloodVolume < ACEGVAR(medical,const_stableVitalsBloodThreshold)) exitWith { false };

if IN_CRDC_ARRST(_unit) exitWith { false };
if (_unit getVariable [QEGVAR(surgery,sedated), false]) exitWith { false };
if (_unit getVariable [QEGVAR(surgery,reboa), false]) exitWith { false };

private _cardiacOutput = [_unit] call ACEFUNC(medical_status,getCardiacOutput);
private _bloodLoss = _unit call ACEFUNC(medical_status,getBloodLoss);
if (_bloodLoss > (ACEGVAR(medical,const_bloodLossKnockOutThreshold) * _cardiacOutput / 2)) exitWith { false };

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 50 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
if (_heartRate < 40) exitWith { false };

private _o2 = GET_SPO2(_unit);
if (_o2 < EGVAR(breathing,Stable_spo2)) exitWith { false };

true
