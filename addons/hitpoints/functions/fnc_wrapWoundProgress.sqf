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
TRACE_1("WrapWoundprogress",_bodyPart);
private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _bandagedWoundsOnPart = _bandagedWounds get _bodyPart;

// Stop treatment if there are no wounds that can be stitched remaining
if (_bandagedWoundsOnPart isEqualTo []) exitWith {false};

// Not enough time has elapsed to stitch a wound
if (_totalTime - _elapsedTime > ([_patient, _bodyPart] call FUNC(getWrapTime)) - 4) exitWith {true};

// Stitch the first possible wound on the body part
private _wrapped = [_patient, _bodyPart] call FUNC(wrapWound);


