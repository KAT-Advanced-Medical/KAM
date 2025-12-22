#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Calculate stroke volume of a single heart beat.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 *    stroke volume (l) <NUMBER>
 *
 * Example:
 * [player] call kat_vitals_fnc_getStrokeVolume
 *
 * Public: No
 */

params ["_unit"];
private _defaultCVP = 6;
private _strokeVolume = 0.095;
private _targetCO = 0.1172072;
private _heartRate = GET_HEART_RATE(_unit);
private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];
private _bloodVolumeRatio = GET_BLOOD_VOLUME_LITERS(_unit) / DEFAULT_BLOOD_VOLUME;
private _ptxSource = _unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]];
private _ptxBase = ((_ptxSource) select 0) + ((_ptxSource) select 1);
private _hptxSource = _unit getVariable [QEGVAR(breathing,hemopneumothorax), [0, 0]];
private _hptxBase = ((_hptxSource) select 0) + ((_hptxSource) select 1);
private _tamponadeBase = _unit getVariable [QEGVAR(circulation,effusion), 0];
private _traliBase = _unit getVariable [QEGVAR(breathing,TRALI), 0];
private _ptxNormalized = linearConversion [0, 16, _ptxBase, 0, 0.5, true];
private _hptxNormalized = linearConversion [0, 2, _hptxBase, 0, 0.5, true];
private _tamponadeNormalized = linearConversion [0, 4, _tamponadeBase, 0, 0.5];
private _traliNormalized = linearConversion [0, 30, _traliBase, 0, 0.5, true];
private _vrEff = 1 - (_ptxNormalized * 0.6) - (_tamponadeNormalized * 0.7) - (_traliNormalized * 0.3) - (_hptxNormalized * 0.5);
_vrEff = _vrEff max 0.1;
private _tachyPenalty = 1;
private _afterload = 1 / (_bloodVolumeRatio max 0.3);
private _contractility = (_unit getVariable [QEGVAR(pharma,heartContractility), 1]) max 0.2;
private _fillTime = _defaultHeartRate / (_heartRate max 0.05);
if (_heartRate > 140) then {
    _tachyPenalty = linearConversion [0.25, 0.15, _fillTime, 1, 0.5, true];
};
private _fillPortion = 1 - exp (-3 * _fillTime);
private _effectiveCVP = _defaultCVP * _bloodVolumeRatio * _vrEff;
private _edv = _fillPortion * _effectiveCVP * 0.25 * _strokeVolume;
private _baselineEDV = _defaultCVP * 0.25 * _strokeVolume;
private _edvNorm = (_edv / _baselineEDV) max 0.05;
private _starlingRaw = 1 / (1 + exp (-6 * (_edvNorm - 1)));
private _starlingGain = _starlingRaw / (1 / (1 + exp (-6 * (1 - 1))));
private _adaptiveStrength = linearConversion [0.6, 1.2, _edvNorm, 0.35, 0.15, true];
private _effectiveContractility = _contractility * (1 + ((_starlingGain - 1) * _adaptiveStrength));
private _esv = (_afterload/_effectiveContractility) * (0.5 * _strokeVolume);
private _strokeVol = (_edv - _esv) max 0.001;
TRACE_6("strokeVolume",_edv,_strokeVol,_esv,_heartRate,_fillTime,_bloodVolumeRatio);
_strokeVol