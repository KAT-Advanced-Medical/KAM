#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Callback to wrap wounds on a bodypart
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_wrapWound
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];

private _bandagedWounds = _patient getVariable [VAR_BANDAGED_WOUNDS, []];
if (isNil "_bandagedWounds") exitWith {false};

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
if (_bandagedWoundsOnPart isEqualTo []) exitWith {false};
TRACE_1("WrapWound1",_bandagedWoundsOnPart);

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze"];

private _bandagedIndex = -1;
{
    private _bandageType = _x param [4, ""];
    if (_bandageType in _includedTypes) exitWith { _bandagedIndex = _forEachIndex };
} forEach _bandagedWoundsOnPart;

if (_bandagedIndex == -1) exitWith {false};
TRACE_1("WrapWound2",_bandagedIndex);

private _entry = _bandagedWoundsOnPart select _bandagedIndex;
_entry params ["_classID", "_amount", "_bleeding", "_damage", "_oldBandage"];
TRACE_1("WrapWound3",_oldBandage);
private _newEntry = [
    _classID,
    _amount,
    _bleeding,
    _damage,
    _oldBandage + "_wrapped"
];
TRACE_2("Wound Before/After Wrap", _entry, _newEntry);
TRACE_1("WrapWound4",_newEntry);
_bandagedWoundsOnPart set [_bandagedIndex, _newEntry];
_bandagedWounds set [_bodyPart, _bandagedWoundsOnPart];
TRACE_1("WrapWound5",_bandagedWounds);
_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];

private _impact = 1;
private _woundIndex = _bandagedIndex;
private _wound = _newEntry;
private _bandage =_oldBandage + "_wrapped";

[_patient, _impact, _bodyPart, _woundIndex, _wound, _bandage, false] call ACEFUNC(medical_treatment,handleBandageOpening);

true