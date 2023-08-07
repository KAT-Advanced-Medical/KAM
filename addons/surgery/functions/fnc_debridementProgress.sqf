#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles the surgical kit treatment by periodically debriding open wounds.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Medic (not used) <OBJECT>
 *   1: Patient <OBJECT>
 *   2: Body Part <STRING>
 * 1: Elapsed Time <NUMBER>
 * 2: Total Time <NUMBER>
 *
 * Return Value:
 * Continue Treatment <BOOL>
 *
 * Example:
 * [[objNull, player], 5, 10] call kat_surgery_fnc_debridementProgress
 *
 * Public: No
 */

params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_medic", "_patient", "_bodyPart"];
_bodyPart = toLower _bodyPart;

private _openWounds = GET_OPEN_WOUNDS(_patient);
private _openWoundsOnPart = _openWounds get _bodyPart;

// Stop treatment if there are no wounds that can be debrided remaining
if (_openWoundsOnPart isEqualTo []) exitWith {false};

if (_totalTime - _elapsedTime > ([_patient, _patient, _bodyPart] call FUNC(getDebrideTime)) - GVAR(woundDebrideTime)) exitWith {true};

private _debridedWound = _openWoundsOnPart deleteAt (count _openWoundsOnPart - 1);
_debridedWound params ["_debridedID", "_debridedAmountOf", "", "_debridedDamageOf"];

private _debridementWounds = GET_DEBRIDED_WOUNDS(_patient);
private _debridementOnPart = _debridementWounds getOrDefault [_bodyPart, [], true];

private _woundIndex = _debridementOnPart findIf {
    _x params ["_classID"]; 
    _classID == _debridedID
};

if (_woundIndex == -1) then {
    _debridementOnPart pushBack _debridedWound;
} else {
    private _wound = _debridementOnPart select _woundIndex;
    _wound set [1, (_wound select 1) + _debridedAmountOf];
};

_patient setVariable [QACEGVAR(medical,openWounds), _openWounds, true];
_patient setVariable [VAR_DEBRIDED_WOUNDS, _debridementWounds, true];

[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);
[_patient] call ACEFUNC(medical_engine,updateDamageEffects);
