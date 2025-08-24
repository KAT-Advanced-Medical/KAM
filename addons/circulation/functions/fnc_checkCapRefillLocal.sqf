#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Local callback for checking the pulse or heart rate of a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head"] call kat_circulation_fnc_checkPulseLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
private _tourniquets = GET_TOURNIQUETS(_patient);
private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _idx = _occlusionMap findIf { _x#0 == _part };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isOccluded = { _tourniquets select _x != 0 } count _result > 0;

private _capRefillOutput = LSTRING(Check_capRefill_Output_Normal);
private _logCapRefillOutput = LSTRING(Check_capRefill_Output_Normal_log);
private _cardiacOutput = _patient call EFUNC(vitals,getCardiacOutput);
private _strokeVolume = _patient call EFUNC(vitals,getDefaultStrokeVolume);
private _defaultCardiacOutput = (_strokeVolume * _heartRate) / 60;
private _cardiacOutputRatio = _cardiacOutput/_defaultCardiacOutput;
if (_isOccluded) then {
    _capRefillOutput = LSTRING(Check_capRefill_Output_NoRefill);
    _logCapRefillOutput = LSTRING(Check_capRefill_Output_NoRefill_log);
} else {
    switch (true) do {
        case (_cardiacOutput >= (0.95 * _cardiacOutputRatio)): {
            // Normal refill ≤ 2s
            _capRefillOutput = LSTRING(Check_capRefill_Output_Normal);
            _logCapRefillOutput = LSTRING(Check_capRefill_Output_Normal_log);
        };
        case (_cardiacOutput >= (0.80 * _cardiacOutputRatio) && _cardiacOutput < (0.95 * _cardiacOutputRatio)): {
            // Delayed refill ~3-4s
            _capRefillOutput = LSTRING(Check_capRefill_Output_Delayed);
            _logCapRefillOutput = LSTRING(Check_capRefill_Output_Delayed_log);
        };
        case (_cardiacOutput < (0.80 * _cardiacOutputRatio)): {
            // Severely delayed refill ≥ 5s
            _capRefillOutput = LSTRING(Check_capRefill_Output_SeverelyDelayed);
            _logCapRefillOutput = LSTRING(Check_capRefill_Output_SeverelyDelayed_log);
        };
    };
};

[_patient, "quick_view", LSTRING(Check_Neck_Output), [_medic call ACEFUNC(common,getName), _logCapRefillOutput]] call ACEFUNC(medical_treatment,addToLog);
[QACEGVAR(common,displayTextStructured), [[_capRefillOutput, _patient call ACEFUNC(common,getName)], 1.5, _medic], _medic] call CBA_fnc_targetEvent;