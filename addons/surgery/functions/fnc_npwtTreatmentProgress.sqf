#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local call for clearing all stitched and bandaged wounds on a patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_npwtTreatmentLocal;
 *
 * Public: No
 */
params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_medic", "_patient", "_bodyPart"];
_bodyPart = toLower _bodyPart;

private _debridedWounds = GET_DEBRIDED_WOUNDS(_patient);
private _debridedWoundsOnPart = _debridedWounds get _bodyPart;
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
private _stitchedWoundsOnPart = _stitchedWounds get _bodyPart;

if (_debridedWoundsOnPart isEqualTo [] && _stitchedWoundsOnPart isEqualTo []) exitWith {false};

if (_totalTime - _elapsedTime > ([_patient, _patient, _bodyPart] call FUNC(getNPWTTime)) - GVAR(npwtTime)) exitWith {true};

//debrided wounds healing
private _clearedWoundFromDebridement = _debridedWoundsOnPart deleteAt (count _debridedWoundsOnPart - 1);
_clearedWoundFromDebridement params ["", "", "", "_clearedDebrideDamage"];
_debridedOnPart deleteAt _clearedWoundFromDebridement;
private _clearedWoundFromStitching = _stitchedWoundsOnPart deleteAt (count _stitchedWoundsOnPart - 1);
_clearedWoundFromStitching params ["", "", "", "_clearedStitchDamage"];
_stitchedOnPart deleteAt _clearedWoundFromStitching;

private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _bodyPartDamage = _patient getVariable [QACEGVAR(medical,bodyPartDamage), []];
_bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) - (_clearedDebrideDamage + _clearedStitchDamage)];
_patient setVariable [QACEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];

switch (_bodyPart) do {
    case "head": {[_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);};
    case "body": {[_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);};
    case "leftarm";
    case "rightarm": {[_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);};
    default {[_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals);};
};

[_patient] call ACEFUNC(medical_engine,updateDamageEffects);
[_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);