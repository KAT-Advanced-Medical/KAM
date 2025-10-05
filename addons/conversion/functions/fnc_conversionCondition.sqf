#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Check if a unit is in a stable state for resource conversion
 *
 * Arguments:
 * 0: The patient <OBJECT>
 *
 * Return Value:
 * Has no critical health conditions <BOOL>
 *
 * Example:
 * [player] call kat_conversion_conversionCondition
 *
 * Public: No
 */

params ["_unit"];

private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_unit);
if ((_bloodVolume < ACEGVAR(medical,const_stableVitalsBloodThreshold)) && (GVAR(conversionRequirements) > 0)) exitWith { false };

if (IN_CRDC_ARRST(_unit) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
private _map = _bloodPressureL + (0.3333333333 * (_bloodPressureH - _bloodPressureL));
if ((_map < 70 || _map > 110) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _heartRate = GET_HEART_RATE(_unit);
private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
if ((_heartRate < (_defaultHeartRate - 25) || _heartRate > (_defaultHeartRate + 25)) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _o2 = GET_KAT_SPO2(_unit);
if ((_o2 < EGVAR(breathing,Stable_spo2)) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _ptx = _unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]];
if (((selectMax _ptx) > 0) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _hemopneumothorax = _unit getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]];
private _tensionpneumothorax = _unit getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]];
if (((_tensionpneumothorax select 0) || (_tensionpneumothorax select 1) || (_hemopneumothorax select 0) || (_hemopneumothorax select 1)) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _fractures = _unit getVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0,0,0,0,0,0,0]];
if ((({_x == 0} count _fractures) != 6) && (GVAR(conversionRequirements) > 1)) exitWith { false };

private _unitTemperature = _unit getVariable [QGVAR(unitTemperature), 37];
if ((_unitTemperature < 34) && (GVAR(conversionRequirements) > 0)) exitWith { false };

private _jointInjuries = GET_JOINTS(_unit);
private _hasInjury = false;
{
    {
        if (_x > 0) exitWith { _hasInjury = true };
    } forEach _x;
    if (_hasInjury) exitWith {};
} forEach _jointInjuries;
if ((_hasInjury) && (GVAR(conversionRequirements) > 1)) exitWith { false };

if ((_unit getVariable [QEGVAR(surgery,reboa), false]) && (GVAR(conversionRequirements) > 1)) exitWith { false };

true