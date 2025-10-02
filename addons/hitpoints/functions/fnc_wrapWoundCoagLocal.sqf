#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
/*
 * Author: Cplhardcore, 
 * Function to wrap all wrappable wounds on a specified body part
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * True if at least one wound was wrapped, otherwise false <BOOL>
 *
 * Example:
 * [player, "RightLeg"] call kat_hitpoints_fnc_wrapWound
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _bandagedWounds = GET_COAGED_WOUNDS(_patient);
private _wrappedWounds = _patient getVariable [VAR_WRAPPED_WOUNDS, createHashMap];
private _wounds = _bandagedWounds getOrDefault [_bodyPart, []];
TRACE_1("WrapAllWounds1",_wounds);
private _wrappedAny = false;

private _newBandagedWounds = [];
private _newWrappedWounds = _wrappedWounds getOrDefault [_bodyPart, []];

{
    _x params ["_id", "_amount", "_bleeding", "_damage", "_bandage"];
    TRACE_4("aaa",_id,_amount,_bleeding,_bandage);
    private _classIndex = _id / 10;
     private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

    if (("BloodClot" in _bandage) && (_className != "InternalBleeding")) then {
        // Create wrapped wound
        private _newClassID = _id + 0.01;
        private _newBandage = _bandage + "_wrapped";
        private _newWound = [_newClassID, _amount, _bleeding, _damage, _newBandage];

        TRACE_2("Wound Before/After Wrap",_x,_newWound);

        // Add to wrapped wounds
        _newWrappedWounds pushBack _newWound;

        // Call ACE handling
        private _impact = 1;
        private _woundIndex = count _newWrappedWounds - 1;
        [_patient, _impact, _bodyPart, _woundIndex, _newWound, _newBandage, false] call EFUNC(misc,handleWrappedReopening);

        _wrappedAny = true;
    } else {
        _newBandagedWounds pushBack _x; // keep unwrapped wounds
    };
} forEach _wounds;

// Update bandaged wounds
if (_newBandagedWounds isEqualTo []) then {
    _bandagedWounds deleteAt _bodyPart;
} else {
    _bandagedWounds set [_bodyPart, _newBandagedWounds];
};

// Update wrapped wounds
if (_newWrappedWounds isNotEqualTo []) then {
    _wrappedWounds set [_bodyPart, _newWrappedWounds];
};

// Store updated variables
_patient setVariable [VAR_COAGED_WOUNDS, _bandagedWounds, true];
_patient setVariable [VAR_WRAPPED_WOUNDS, _wrappedWounds, true];

_wrappedAny