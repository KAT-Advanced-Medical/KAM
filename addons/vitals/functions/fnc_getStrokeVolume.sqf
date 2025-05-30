#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Calculate stroke volume of a single heart beat.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 *    stroke volume (ml) <NUMBER>
 *
 * Example:
 * [player] call kat_vitals_fnc_getStrokeVolume
 *
 * Public: No
 */

params ["_unit"];
private _defaultCVP = 6;
private _strokeVolume = 0.095;
private _heartRate = GET_HEART_RATE(_unit);
private _bloodPressure = _unit getVariable [VAR_BLOOD_PRESS, DEFAULT_BLOOD_PRESSURE];

private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
private _heartRateRatio = GET_HEART_RATE(_unit) / _defaultHeartRate;
private _bloodVolumeRatio = GET_BLOOD_VOLUME_LITERS(_unit) / DEFAULT_BLOOD_VOLUME;
private _vasoconstriction = GET_VASOCONSTRICTION(_unit);
private _ptxBase = ((_unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]]) select 0) + ((_unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]]) select 1);
private _tamponadeBase = _unit getVariable [QEGVAR(circulation,effusion), 0];
private _ptxNormalized = linearConversion [0, 8, _ptxBase, 0, 1];
private _tamponadeNormalized = linearConversion [0, 4, _tamponadeBase, 0, 1];
private _cvp = (_defaultCVP * _heartRateRatio * _bloodVolumeRatio * (1 + _ptxNormalized) * (1 + _tamponadeNormalized));
private _afterload = ((_bloodPressure select 1) / (DEFAULT_BLOOD_PRESSURE select 1)) * _vasoconstriction * _bloodVolumeRatio;
private _contractility = _unit getVariable [QEGVAR(pharma,heartContractility), 1];

private _fillTime = _defaultHeartRate / _heartRate;
private _fillPortion = 1 - exp (-3 * _fillTime);
private _edv = _fillPortion * _cvp * 1.4 * _strokeVolume;

private _esv = (_afterload/_contractility) * (0.5 * _strokeVolume);

private _strokeVol = (_edv - _esv) max 0;

_strokeVol
