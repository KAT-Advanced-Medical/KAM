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

if (_stitchableWounds isEqualTo createHashMap) exitWith { false };

if (
    _totalTime - _elapsedTime >
    ([_patient, _patient] call FUNC(getStitchTimeFullBody)) - ACEGVAR(medical_treatment,woundStitchTime)
) exitWith { true };

private _bandagedWounds  = GET_BANDAGED_WOUNDS(_patient);
private _wrappedWounds   = GET_WRAPPED_WOUNDS(_patient);
private _coagWounds      = GET_COAGED_WOUNDS(_patient);
private _stitchedWounds  = GET_STITCHED_WOUNDS(_patient);

private _bodyPart = (keys _stitchableWounds) select 0;

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
private _wrappedWoundsOnPart  = _wrappedWounds  getOrDefault [_bodyPart, []];
private _coagWoundsOnPart     = _coagWounds     getOrDefault [_bodyPart, []];

private _allWounds = [];
{
    _x params ["_array", "_source"];
    {
        _allWounds pushBack [_x, _forEachIndex, _source];
    } forEach _array;
} forEach [
    [_bandagedWoundsOnPart, "bandaged"],
    [_wrappedWoundsOnPart,  "wrapped"],
    [_coagWoundsOnPart,     "coag"]
];

private _treatedWound  = [];
private _treatedIndex  = -1;
private _treatedSource = "";

for "_i" from ((count _allWounds) - 1) to 0 step -1 do {
    _allWounds select _i params ["_wound", "_index", "_source"];
    _wound params ["_treatedID", "", "", "", "_type"];

    private _classIndex = _treatedID / 10;
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

    if (
        !(_className in ["InternalBleeding", "Evisceration", "Thermal_Burn"])
        && !(_type in ["ETD", "Israeli_Bandage"])
    ) exitWith {
        _treatedWound  = _wound;
        _treatedIndex  = _index;
        _treatedSource = _source;
    };
};

if (_treatedIndex == -1) exitWith { false };
private _sourceArray = switch (_treatedSource) do {
    case "bandaged": { _bandagedWoundsOnPart };
    case "wrapped":  { _wrappedWoundsOnPart };
    case "coag":     { _coagWoundsOnPart };
};
_treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

private _stitchedAmount = _treatedAmountOf min 1;
private _remaining      = _treatedAmountOf - _stitchedAmount;

if (_remaining <= 0) then {
    _sourceArray deleteAt _treatedIndex;
} else {
    _treatedWound set [1, _remaining];
};

private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_bodyPart, [], true];

private _stitchedIndex = _stitchedWoundsOnPart findIf {
    _x params ["_classID"];
    _classID == _treatedID
};

if (_stitchedIndex == -1) then {
    _stitchedWoundsOnPart pushBack [
        _treatedID,
        _stitchedAmount,
        0,
        _treatedDamageOf,
        "Stitched"
    ];
} else {
    private _existing = _stitchedWoundsOnPart select _stitchedIndex;
    _existing set [1, (_existing select 1) + _stitchedAmount];
};

private _trauma = _treatedDamageOf * _stitchedAmount;
if (GVAR(clearTrauma) == 1) then {
    [_patient, _bodyPart, -_trauma] call ACEFUNC(medical_treatment,addTrauma);
} else {
    [_patient, _bodyPart, -(_trauma * 0.5)] call ACEFUNC(medical_treatment,addTrauma);
};

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
_patient setVariable [VAR_WRAPPED_WOUNDS,  _wrappedWounds,  true];
_patient setVariable [VAR_COAGED_WOUNDS,   _coagWounds,     true];
_patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

if (
    ACEGVAR(medical,limping) == 2
    && { _patient getVariable [QEGVAR(medical,isLimping), false] }
    && { _bodyPart in ["leftleg", "rightleg", "upperleftleg", "upperrightleg"] }
) then {
    [QEGVAR(medical_engine,updateDamageEffects), _patient, _patient]
        call CBA_fnc_targetEvent;
};

if (GVAR(consumeSurgicalKit) == 2) then {
    ([_medic, _patient, ["ACE_suture"]] call FUNC(useItem)) params ["_user"];
    !isNull _user
} else {
    true
};