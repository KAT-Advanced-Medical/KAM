#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut, mharis001
 * Handles the surgical kit treatment by periodically closing bandaged wounds.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Medic (not used) <OBJECT>
 *   1: Patient <OBJECT>
 * 1: Elapsed Time <NUMBER>
 * 2: Total Time <NUMBER>
 *
 * Return Value:
 * Continue Treatment <BOOL>
 *
 * Example:
 * [[objNull, player], 5, 10] call kat_misc_fnc_surgicalKitProgressFullBody
 *
 * Public: No
 */

params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_medic", "_patient"];

private _stitchableWounds = _patient call FUNC(getFullBodyStitchableWounds);

// Stop treatment if there are no wounds that can be stitched remaining
if (_stitchableWounds isEqualTo createHashMap) exitWith {false};

if (_totalTime - _elapsedTime > ([_patient, _patient] call FUNC(getStitchTimeFullBody)) - ACEGVAR(medical_treatment,woundStitchTime)) exitWith {true};

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);

private _bodyPart = (keys _stitchableWounds) select 0;
private _bandagedWoundsOnPart = _bandagedWounds get _bodyPart;
private _treatedWound = [];

{
    private _candidate = _x;
        _candidate params ["_id"];
        private _classIndex = _id / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

        if !(_className in ["InternalBleeding", "Evisceration"]) exitWith {
            _treatedWound = _candidate;
            _bandagedIndex = _forEachIndex;
            _bandagedWoundsOnPart deleteAt _bandagedIndex;
        };
    } forEach _bandagedWoundsOnPart;
_treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

// Check if we need to add a new stitched wound or increase the amount of an existing one
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_bodyPart, [], true];

private _woundIndex = _stitchedWoundsOnPart findIf {
    _x params ["_classID"];
    _classID == _treatedID
};

if (_woundIndex == -1) then {
    (_stitchedWounds getOrDefault [_bodyPart, [], true]) pushBack _treatedWound;
} else {
    private _wound = (_stitchedWounds get _bodyPart) select _woundIndex;
    _wound set [1, (_wound select 1) + _treatedAmountOf];
};

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
_patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

if (ACEGVAR(medical_treatment,clearTrauma) == 1) then {
    private _partIndex = ALL_BODY_PARTS find _bodyPart;
    TRACE_2("clearTrauma - clearing trauma after stitching",_bodyPart,_treatedWound);
    private _bodyPartDamage = GET_BODYPART_DAMAGE(_patient);
    _bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) - (_treatedDamageOf * _treatedAmountOf)];
    _patient setVariable [QEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];
    TRACE_2("clearTrauma - healed damage",_bodyPart,_treatedDamageOf);

    switch (_bodyPart) do {
        case "head": { [_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "body": { [_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "leftarm";
        case "rightarm": { [_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        default { [_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
    };
};

if (
    ACEGVAR(medical,limping) == 2
    && {_patient getVariable [QACEGVAR(medical,isLimping), false]}
    && _bodyPart in ["leftleg", "rightleg", "upperleftleg", "upperrightleg"]
) then {
    TRACE_3("Updating damage effects",_patient,_bodyPart,local _patient);
    [QACEGVAR(medical_engine,updateDamageEffects), _patient, _patient] call CBA_fnc_targetEvent;
};

if (ACEGVAR(medical_treatment,consumeSurgicalKit) == 2) then {
    // Don't consume a suture if there are no more wounds to stitch
    if (count (values _stitchableWounds) isEqualTo 1) exitWith {false};
    ([_medic, _patient, ["ACE_suture"]] call ACEFUNC(medical_treatment,useItem)) params ["_user"];
    !isNull _user
} else {
    true
};

false
