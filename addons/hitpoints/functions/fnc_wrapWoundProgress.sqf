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
 * [player, "rightleg"] call kat_hitpoints_fnc_wrapWoundProgress

 *
 * Public: No
 */

params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_medic", "_patient", "_bodyPart"];
TRACE_5("WrapWoundprogress",_bodyPart,_patient,_medic,_elapsedTime,_totalTime);
private _bandagedWounds = _patient getVariable [VAR_BANDAGED_WOUNDS, []];
private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];

// Exit early if there are no bandages on this body part
if (_bandagedWoundsOnPart isEqualTo []) exitWith {false};

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze"];

private _hasValidBandage = false;
{
    private _bandageType = _x param [4, ""];
    if (_bandageType in _includedTypes) exitWith {
        _hasValidBandage = true;
        true
    };
} forEach _bandagedWoundsOnPart;
if (!_hasValidBandage) exitWith {false};

// Not enough time has elapsed to stitch a wound
if (_totalTime - _elapsedTime > ([_patient, _patient, _bodyPart] call FUNC(getWrapTime)) - GVAR(woundWrapTime)) exitWith {diag_Log "not enough time"};
if (_totalTime - _elapsedTime > ([_patient, _patient, _bodyPart] call FUNC(getWrapTime)) - GVAR(woundWrapTime)) exitWith {true};

if (((_totalTime - _elapsedTime) % GVAR(woundWrapTime)) == 1 ) then {true};

// Stitch the first possible wound on the body part
private _wrapped = [_patient, _bodyPart] call FUNC(wrapWound);
TRACE_2("WrapWoundcall",_bodyPart,_patient);