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
// =======================
// BASELINE CONSTANTS
// =======================
#define BASELINE_SV 0.0879        // 87.9 mL
#define BASELINE_EF 0.6
#define BASELINE_EDV (BASELINE_SV / BASELINE_EF)
#define BASELINE_ESV (BASELINE_EDV - BASELINE_SV)
#define BASELINE_MAP 93  

// =======================
// INPUTS
// =======================
private _map = GET_MAP(_unit);
private _defaultCVP = 6;
private _heartRate = GET_HEART_RATE(_unit);
private _bloodVolumeRatio = GET_BLOOD_VOLUME_LITERS(_unit) / DEFAULT_BLOOD_VOLUME;

private _contractility =
    (_unit getVariable [QEGVAR(pharma,heartContractility), 1]) max 0.2;

// =======================
// OBSTRUCTIVE FACTORS
// =======================
private _ptxArray = (_unit getVariable [QEGVAR(breathing,pneumothorax), [0,0]]);
private _tptxArray = (_unit getVariable [QEGVAR(breathing,tensionpneumothorax), [0,0]]);
private _hptxArray = (_unit getVariable [QEGVAR(breathing,hemopneumothorax), [0,0]]);
private _ptx = ((_ptxArray select 0) + (_ptxArray select 1));
private _hptx = ((_hptxArray select 0) + (_hptxArray select 1));


private _tamponade = _unit getVariable [QEGVAR(circulation,effusion), 0];
private _trali = _unit getVariable [QEGVAR(breathing,TRALI), 0];

private _vrEff =
    1
    - (linearConversion [0,16,_ptx,0,0.3,true])
    - (linearConversion [0,2,_hptx,0,0.4,true])
    - (linearConversion [0,4,_tamponade,0,0.5,true])
    - (linearConversion [0,30,_trali,0,0.2,true]);

_vrEff = _vrEff max 0.1;
private _rvAfterload = 1;
private _rvFailure = 1;
if ((_tptxArray select 0) || (_tptxArray select 1)) then {
    _rvAfterload =
        linearConversion
    [
        0, 16,          // PTX scale
        _ptx,
        1.0, 2.5,       // RV afterload multiplier
        true
    ];

// RV stroke limitation (Frank–Starling failure)
    _rvFailure =
        linearConversion
    [
        0.3, 1.5,       // mild → severe RV strain
        _rvAfterload,
        1.0, 0.35,      // full → failing RV
        true
    ];

};

// =======================
// HEART RATE FILLING
// =======================
private _fillTime =
    linearConversion [40, 160, _heartRate, 1.2, 0.6, true];

private _fillPortion = 1 - exp (-3 * _fillTime);

// =======================
// VENOUS COMPENSATION
// =======================
_bvComp =
    linearConversion
    [
        0.75, 1.0,
        _bloodVolumeRatio,
        0.85, 1.0,
        true
    ];
private _shockClass =
    _unit getVariable [QGVAR(shockClass), "NONE"];
private _globalVaso = GET_VASOCONSTRICTION(_unit);
private _vasoTone = switch (_shockClass) do {
    case "NONE":          { 1.0 };
    case "COMPENSATED":   { 1.2 };   // strong sympathetic response
    case "DECOMPENSATED": { 1.05 };  // partial failure
    case "TERMINAL":      { 0.75 };  // vasoplegia
    default               { 1.0 };
};
private _effectiveVaso =
    _globalVaso * _vasoTone;

_effectiveVaso = _effectiveVaso min 1.4 max 0.6;
private _effectiveCVP =
    _defaultCVP
    * _bvComp
    * _effectiveVaso
    * _vrEff;
private _arterialEffect = linearConversion [0.7, 1.3, _effectiveVaso, 0.85, 1.25, true];
TRACE_8(
    "_effectiveCVP",
    _defaultCVP,
    _bvComp,
    _effectiveVaso,
    _globalVaso,
    _vasoTone,
    _fillPortion,
    _effectiveCVP,
    _defaultCVP
);
// =======================
// PRELOAD & STARLING
// =======================
private _preload =
    (_effectiveCVP / _defaultCVP)
    * _rvFailure
    min 1.3
    max 0.2;

private _edv =
    BASELINE_EDV
    * _preload
    * (0.85 + 0.15 * _fillPortion);

private _edvNorm = (_edv / BASELINE_EDV) min 1.4 max 0.4;

private _restEDV = BASELINE_EDV * _fillPortion;
private _edvRel = _edv / _restEDV;

private _starlingGain =
    linearConversion
    [
        0.7, 1.2,        // relative EDV range
        _edvRel,
        0.8, 1.15,      // gain range
        true
    ];

_starlingGain = _starlingGain min 1.35;
TRACE_8(
    "_starlingGain",
    _starlingGain,
    _edvNorm,
    _edv,
    BASELINE_EDV,
    _preload,
    _fillPortion,
    _effectiveCVP,
    _defaultCVP
);
// =======================
// AFTERLOAD & ESV
// =======================
private _mapNorm =
    linearConversion
    [
        50, 130,     // hypotension → severe HTN
        _map,
        0.65, 1.35,  // afterload multiplier
        true
    ];
    private _mapShock = switch (_shockClass) do {
        case "COMPENSATED":   { 1.1 };
        case "DECOMPENSATED": { 1.0 };
        case "TERMINAL":      { 0.8 };
        default               { 1.0 };
    };
_mapNorm =
    _mapNorm * _mapShock;
    
private _vasoAfterload =
    linearConversion
    [
        0.6, 1.4,
        _effectiveVaso,
        0.85, 1.25,
        true
    ];
private _afterload =
    _mapNorm
    * _vasoAfterload;
private _effectiveContractility =
    _contractility * _starlingGain;

private _esv =
    BASELINE_ESV * (_afterload / _effectiveContractility);
TRACE_6(
    "esv",
    _afterload,
    _effectiveContractility,
    _contractility,
    _starlingGain,
    _bloodVolumeRatio,
    _arterialEffect
);
_esv = _esv min (_edv * 0.95);
// =======================
// FINAL STROKE VOLUME
// =======================
private _strokeVol = (_edv - _esv) max 0.001;

TRACE_6(
    "strokeVolume",
    _edv,
    _strokeVol,
    _esv,
    _heartRate,
    _fillTime,
    _bloodVolumeRatio
);

_strokeVol