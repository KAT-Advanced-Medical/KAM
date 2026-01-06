#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Modified: Blue
 * Calculate the blood pressure of a unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * 0: BloodPressure Low <NUMBER>
 * 1: BloodPressure High <NUMBER>
 *
 * Example:
 * [player] call ace_medical_status_fnc_getBloodPressure
 *
 * Public: No
 */
params ["_unit"];
#define BASELINE_MAP 94.7
#define BASELINE_CO  0.1054056 // L/s
#define BASELINE_SVR (94.7 / 0.1054056 )  // ≈ 860
private _cardiacOutput = [_unit] call EFUNC(vitals,getCardiacOutput);
private _strokeVolume  = [_unit] call EFUNC(vitals,getStrokeVolume);
private _heartRate     = GET_HEART_RATE(_unit);

private _resistance        = _unit getVariable [VAR_PERIPH_RES, DEFAULT_PERIPH_RES];
private _vasoconstriction  = GET_VASOCONSTRICTION(_unit);
private _tourniquets       = GET_TOURNIQUETS(_unit);
private _icp               = GET_ICP(_unit);
private _occlusionMap = [
    [3, [3, 8, 9, 10, 11]],
    [4, [4]],
    [5, [4, 5]],
    [6, [6]],
    [7, [6, 7]],
    [8, [8]],
    [9, [8, 9]],
    [10, [10]],
    [11, [10, 11]]
];

private _occludedParts = [];
{
    private _idx = _x#0;
    if (_tourniquets select _idx != 0) then {
        { if !(_x in _occludedParts) then { _occludedParts pushBack _x; }; } forEach (_x#1);
    };
} forEach _occlusionMap;

private _countOccluded = count _occludedParts;
private _prevMAP = GET_MAP(_unit);
if (_icp > 25 && _prevMAP < 70) then {
    _resistance = _resistance * linearConversion [25, 40, _icp, 1.1, 1.4, true];
};

private _map =
    (_cardiacOutput
    * BASELINE_SVR
    * (_resistance / 100)
    * ((_vasoconstriction max 0.4) min 1.8))
    * (1.07 ^ _countOccluded);
TRACE_5("BP2", _map, _vasoconstriction, _resistance, BASELINE_SVR, _cardiacOutput);
private _cushing = [_unit] call EFUNC(vitals,getCushings);
if (_cushing > 0) then {
    _map = _map * linearConversion [0, 1, _cushing, 1.0, 1.35, true];
    _map = _map min 140;
};

_unit setVariable [QGVAR(map), _map];
TRACE_1("BP3", _map);
private _basePulsePressure = _map * 0.43;
TRACE_1("BP4", _basePulsePressure);
private _baselineSV = 0.0862038;
private _svFactor =
    linearConversion [0.03, _baselineSV, _strokeVolume, 0.4, 1.0, true];
private _shockClass = _unit getVariable [QEGVAR(vitals,shockClass), "NONE"];
private _shockPPMult = switch (_shockClass) do {
    case "COMPENSATED":   { 0.9 };
    case "DECOMPENSATED": { 0.7 };
    case "TERMINAL":      { 0.45 };
    default               { 1.0 };
};
private _bradyFactor =
    linearConversion [80, 40, _heartRate, 0, 1, true];

private _cushingPPMult =
    1 + (_cushing * _bradyFactor * 0.6);

private _pulsePressure =
    _basePulsePressure
    * _svFactor
    * _shockPPMult
    * _cushingPPMult;
_pulsePressure = _pulsePressure max (_map * 0.15) min (_map * 0.9);
TRACE_1("BP4", _pulsePressure);
private _systolic  = _map + (_pulsePressure * 0.5);
private _diastolic = _map - (_pulsePressure * 0.5);

private _BPChange = _unit getVariable [VAR_BLOODPRESSURE_CHANGE, []];
private _changeSystolic = 0;
private _changeDiastolic = 0;

{
    _changeSystolic  = _changeSystolic  + (_x select 0);
    _changeDiastolic = _changeDiastolic + (_x select 1);
} forEach _BPChange;

[
    (round (_diastolic + _changeDiastolic) max 0),
    (round (_systolic  + _changeSystolic) max 0)
]