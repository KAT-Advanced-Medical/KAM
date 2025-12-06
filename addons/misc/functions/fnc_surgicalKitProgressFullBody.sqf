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

// Get all wounds
private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _wrappedWounds = GET_WRAPPED_WOUNDS(_patient);
private _coagWounds    = GET_COAGED_WOUNDS(_patient);
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);

private _bodyPart = (keys _stitchableWounds) select 0;
private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
private _wrappedWoundsOnPart = _wrappedWounds getOrDefault [_bodyPart, []];
private _coagWoundsOnPart    = _coagWounds getOrDefault [_bodyPart, []];
private _allWounds = [];

// Combine wounds for processing
{
    private _woundArray = _x select 0;
    private _woundSource = _x select 1;
    {
        _allWounds pushBack [_x, _forEachIndex, _woundSource]; // [wound, index, source]
    } forEach _woundArray;
} forEach [
    [_bandagedWoundsOnPart, "bandaged"],
    [_wrappedWoundsOnPart, "wrapped"],
    [_coagWoundsOnPart, "coag"]
];

private _treatedWound = [];
private _treatedSource = "";
private _treatedIndex = -1;
TRACE_7("classIndec1",_wound,_treatedID,_startWound,_index,_source,_maybeWound,_allWounds);

for "_i" from ((count _allWounds) - 1) to 0 step -1 do {
    _maybeWound = _allWounds select _i;
    _maybeWound params ["_wound", "_index", "_source"];
    _wound params ["_treatedID", "", "", "", "_type"];
    TRACE_7("classIndec",_wound,_treatedID,_startWound,_index,_source,_maybeWound,_allWounds);
    private _classIndex = _treatedID / 10;
   
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    TRACE_7("classIndec",_wound,_treatedID,_startWound,_className,_source,_maybeWound,_type);
    if !(_className in ["InternalBleeding", "Evisceration", "Thermal_Burn"] || _type in ["ETD", "Israeli_Bandage"]) then {
        _treatedWound = _wound;
        _treatedSource = _source;
        _treatedIndex = _index;
        TRACE_3("classIndec",_treatedWound,_treatedSource,_treatedIndex);
        break;
    };
};

// Exit if nothing to stitch
if (_treatedWound isEqualTo []) exitWith {false};

// Remove wound from appropriate array
switch (_treatedSource) do {
    case "bandaged": { _bandagedWoundsOnPart deleteAt _treatedIndex };
    case "wrapped":  { _wrappedWoundsOnPart deleteAt _treatedIndex };
    case "coag":     { _coagWoundsOnPart deleteAt _treatedIndex };
};

_treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

// Stitch logic
private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_bodyPart, [], true];
private _woundIndex = _stitchedWoundsOnPart findIf {
    _x params ["_classID"];
    _classID == _treatedID
};

if (_woundIndex == -1) then {
    _stitchedWoundsOnPart pushBack _treatedWound;
} else {
    private _wound = _stitchedWoundsOnPart select _woundIndex;
    _wound set [1, (_wound select 1) + _treatedAmountOf];
};

// Save updated wound states
_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
_patient setVariable [VAR_WRAPPED_WOUNDS, _wrappedWounds, true];
_patient setVariable [VAR_COAGED_WOUNDS, _coagWounds, true];
_patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

if (ACEGVAR(medical_treatment,clearTrauma) == 1) then {
    private _partIndex = ALL_BODY_PARTS find _bodyPart;
    TRACE_2("clearTrauma - clearing trauma after stitching",_bodyPart,_treatedWound);
    private _bodyPartDamage = GET_BODYPART_DAMAGE(_patient);
    _bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) - (_treatedDamageOf * _treatedAmountOf)];
    _patient setVariable [QEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];
    TRACE_2("clearTrauma - healed damage",_bodyPart,_treatedDamageOf);

    switch (_bodyPart) do {
        case "head":     { [_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "body":     { [_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "leftarm";
        case "rightarm": { [_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        default          { [_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
    };
} else {
    private _partIndex = ALL_BODY_PARTS find _bodyPart;
    TRACE_2("clearTrauma - clearing trauma after stitching",_bodyPart,_treatedWound);
    private _bodyPartDamage = GET_BODYPART_DAMAGE(_patient);
    _bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) - ((_treatedDamageOf * _treatedAmountOf) * 0.5)];
    _patient setVariable [QEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];
    TRACE_2("clearTrauma - healed damage",_bodyPart,_treatedDamageOf);

    switch (_bodyPart) do {
        case "head":     { [_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "body":     { [_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        case "leftarm";
        case "rightarm": { [_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        default          { [_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
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
    if (count (values _stitchableWounds) isEqualTo 1) exitWith {false};
    ([_medic, _patient, ["ACE_suture"]] call ACEFUNC(medical_treatment,useItem)) params ["_user"];
    !isNull _user
} else {
    true
};