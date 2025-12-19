#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut, mharis001, LinkIsGrim
 * Stitches a wound (either the first or a specific wound) from a body part.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 * 2: Wound Array, will close first wound on body part if empty <ARRAY> (default: [])
 *
 * Return Value:
 * Wound was stitched <BOOL>
 *
 * Example:
 * [player, "head"] call ace_medical_treatment_fnc_stitchWound
 *
 * Public: No
 */

params ["_patient", "_bodyPart", ["_treatedWound", []]];

// Fetch wounds per body part
private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _wrappedWounds = GET_WRAPPED_WOUNDS(_patient);
private _coagWounds    = GET_COAGED_WOUNDS(_patient);

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
private _wrappedWoundsOnPart  = _wrappedWounds getOrDefault [_bodyPart, []];
private _coagWoundsOnPart     = _coagWounds getOrDefault [_bodyPart, []];

private _unstitchableTypes = ["ETD", "Israeli_Bandage"];

// Combine all wounds into one array for processing
private _allWounds = [];
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

private _treatedSource = "";
private _woundIndex = -1;

if (_treatedWound isEqualTo []) then {
    {
        _x params ["_wound", "_index", "_source"];
        _wound params ["_treatedID", "", "", "", "_type"];

        private _classIndex = _treatedID / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

        if (!(_className in ["InternalBleeding", "Evisceration", "Thermal_Burn"]) && !(_type in _unstitchableTypes)) exitWith {
            _treatedWound = _wound;
            _woundIndex = _index;
            _treatedSource = _source;
        };
    } forEach _allWounds;
};

// Exit if no valid wound found
if (_woundIndex == -1) exitWith { false };

// Remove wound from the correct array
private _sourceArray = switch (_treatedSource) do {
    case "bandaged": { _bandagedWoundsOnPart };
    case "wrapped":  { _wrappedWoundsOnPart };
    case "coag":     { _coagWoundsOnPart };
};

_treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

// Amount stitched this action
private _stitchedAmount = _treatedAmountOf min 1;

// Reduce wound amount
private _remaining = _treatedAmountOf - _stitchedAmount;

if (_remaining <= 0) then {
    _sourceArray deleteAt _woundIndex;
} else {
    _treatedWound set [1, _remaining];
};
// Extract wound data
_treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

// Update stitched wounds
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_bodyPart, [], true];

private _stitchedIndex = _stitchedWoundsOnPart findIf {
    _x params ["_classID"];
    _classID == _treatedID
};

if (_stitchedIndex == -1) then {
    private _newStitched = +_treatedWound;
    _newStitched set [1, _stitchedAmount];
    _stitchedWoundsOnPart pushBack _newStitched;
} else {
    private _existingWound = _stitchedWoundsOnPart select _stitchedIndex;
    _existingWound set [1, (_existingWound select 1) + _stitchedAmount];
};

// Clear trauma if enabled
if (GVAR(clearTrauma) == 1) then {
    [_patient, _bodyPart, -(_treatedDamageOf * _treatedAmountOf)] call ACEFUNC(medical_treatment,addTrauma);
} else {
    [_patient, _bodyPart, -((_treatedDamageOf * _treatedAmountOf) * 0.5)] call ACEFUNC(medical_treatment,addTrauma);
};

// Save updated wound data
_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
_patient setVariable [VAR_WRAPPED_WOUNDS, _wrappedWounds, true];
_patient setVariable [VAR_COAGED_WOUNDS, _coagWounds, true];
_patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

// Limb recheck if necessary
if (
    ACEGVAR(medical,limping) == 2
    && { _patient getVariable [QEGVAR(medical,isLimping), false] }
    && { _bodyPart in ["leftleg", "rightleg", "upperleftleg", "upperrightleg"] }
) then {
    [QEGVAR(medical_engine,updateDamageEffects), _patient, _patient] call CBA_fnc_targetEvent;
};

true