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
private _defaultBloodVolume = DEFAULT_BLOOD_VOLUME;
private _bloodVolume = _unit getVariable [QEGVAR(circulation,bodyFluid), DEFAULT_BODY_FLUID];
private _bloodVolumeFixed = ((_bloodVolume select 4) / 1000) max 0.5;
TRACE_3("strokeVolume1",_bloodVolume,_defaultBloodVolume,_bloodVolumeFixed);
private _bloodVolumeRatio = _bloodVolumeFixed / _defaultBloodVolume;
private _vasoconstriction = GET_VASOCONSTRICTION(_unit);
private _ptxBase = ((_unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]]) select 0) + ((_unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]]) select 1);
private _tamponadeBase = _unit getVariable [QEGVAR(circulation,effusion), 0];
private _ptxNormalized = linearConversion [0, 8, _ptxBase, 0, 1];
private _tamponadeNormalized = linearConversion [0, 4, _tamponadeBase, 0, 1];
private _cvp = (_defaultCVP * _heartRateRatio  * (1 + _ptxNormalized) * (1 + _tamponadeNormalized) * _bloodVolumeRatio);
private _afterload = ((_bloodPressure select 1) / (DEFAULT_BLOOD_PRESSURE select 1)) * _vasoconstriction  * _bloodVolumeRatio;
private _contractility = _unit getVariable [QEGVAR(pharma,heartContractility), 1];

private _fillTime = _defaultHeartRate / (_heartRate max 0.05);
private _fillPortion = 1 - exp (-3 * _fillTime);
private _edv = _fillPortion * _cvp * 1.4 * _strokeVolume;

private _esv = (_afterload/_contractility) * (0.5 * _strokeVolume);
TRACE_5("strokeVolume1.6",_edv,_strokeVolume,_esv,_afterload,_contractility);
private _strokeVol = (_edv - _esv) max 0;
TRACE_8("strokeVolume2",_edv,_strokeVolume,_esv,_cvp,_defaultHeartRate,_heartRate,_fillTime,_bloodVolumeRatio);
_strokeVol
