#include "..\script_component.hpp"
/*
 * Author: kymckay
 * Calculates the time to bandage a wound based on it's size, the patient and the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Treatment Time <NUMBER>
 *
 * Example:
 * [player, cursorTarget, "head", "FieldDressing"] call ace_medical_treatment_fnc_getBandageTime
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_bandage"];

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;
if (_partIndex < 0) exitWith { ERROR_1("invalid partIndex - %1",_this); 0 };

private _targetWounds = [_patient, _bandage, _bodyPart] call ACEFUNC(medical_treatment,findMostEffectiveWounds);
TRACE_1("findMostEffectiveWounds",_targetWounds);

private _woundCount = count _targetWounds;
private _woundKeys = keys _targetWounds;
private _woundValue = _targetWounds get (_woundKeys select 0);
private _woundAmount = _woundValue select 2;
TRACE_3("_woundAmount",_woundAmount,_woundKeys,_woundValue);

// Everything is patched up on this body part already
if (_woundCount == 0) exitWith {0};

// Base bandage time is based on wound size and remaining percentage
private _bandageTimesArray = [BANDAGE_TIME_S, BANDAGE_TIME_M, BANDAGE_TIME_L];
private _bandageTime = 0;

{
    private _wound = _x;
    _wound params ["_classID", "", "_amountOf"];
    _y params ["_effectiveness", "", "_impact"];
    private _category = (_classID % 10);

    // Base bandage time is based on wound size and remaining percentage
    private _woundTime = _bandageTimesArray select _category;

    // Scale bandage time based on amount left and effectiveness (less time if only a little wound left)
    // Basic bandage treatment will have a very high effectiveness and can be ignored
    if (GVAR(advancedBandages != 0)) then {
        _woundTime = _woundTime * linearConversion [0, _effectiveness, _impact, 0.666, 1, true];
    };
    TRACE_1("bandageTime0",_woundTime);
    private _classIndex = _classID / 10;
    private _className  = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    TRACE_1("bandageTime0.5",_className);
    if (_className in ["InternalBleeding"]) then {
        _bandageTime = _bandageTime;
        TRACE_1("bandageTime0.6",_bandageTime);
    } else {
        _bandageTime = _bandageTime + _woundTime;
        TRACE_2("bandageTime0.7",_bandageTime,_woundTime);
    };
} forEach _targetWounds;
TRACE_1("bandageTime1",_bandageTime);

switch (true) do {
        case (_bandage in ["Israeli_Bandage"]): {
            _bandageTime = _bandageTime * 0.9;
            TRACE_1("bandageTime4",_bandageTime);
        };
        case (_bandage in ["ETD"]): {
            _bandageTime = _bandageTime;
            TRACE_1("bandageTime4",_bandageTime);
        };
        case (_bandage in ["Hemostatic_Gauze", "Compressed_Gauze", "fourByfour_Gauze", "Burn_Dressing"]): {
            _bandageTime = _bandageTime * 0.75;
            TRACE_1("bandageTime4",_bandageTime);
        };
        case (_bandage == "Adhesive_Bandage"): {
            _bandageTime = _bandageTime * 0.5;
            TRACE_1("bandageTime4",_bandageTime);
        };
        default {_bandageTime = _bandageTime};
    };

if (_woundCount > 1) then {
    _bandageTime = _bandageTime - (2 * _woundCount);
};
if (_woundAmount > 1) then {
    _bandageTime = _bandageTime * ((1 + (_woundAmount * 0.2)) min 2);
};
TRACE_2("bandageTimeAmount",_bandageTime,_woundAmount);
if ([_medic] call ACEFUNC(medical_treatment,isMedic)) then {
    _bandageTime = _bandageTime * BANDAGE_TIME_MOD_MEDIC;
};
TRACE_1("bandageTime2",_bandageTime);
// Bandaging yourself requires more work
if (_medic == _patient) then {
    _bandageTime = _bandageTime * BANDAGE_TIME_MOD_SELF;
};
switch (true) do {
        case (_bandage in ["Israeli_Bandage"]): {
            _bandageTime = _bandageTime max 6;
            TRACE_1("bandageTime4",_bandageTime);
        };
        case (_bandage in ["ETD"]): {
            _bandageTime = _bandageTime max 12;
            TRACE_1("bandageTime4",_bandageTime);
        };
        default {_bandageTime = _bandageTime};
    };

TRACE_2("bandageTime5",_bandageTime,_woundCount);
// Nobody can bandage instantly
_bandageTime max 3