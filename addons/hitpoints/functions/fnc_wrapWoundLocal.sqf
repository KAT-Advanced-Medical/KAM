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

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _wounds = _bandagedWounds getOrDefault [_bodyPart, []];
TRACE_1("WrapAllWounds1", _wounds);

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze", "Burn_Dressing", "Hemostatic_Gauze"];
private _wrappedAny = false;

// We’ll build a new list of wounds and inject new wrapped ones.
private _newWounds = +_wounds; // clone

{
    _x params ["_id", "_amount", "_bleeding", "_damage", "_bandage"];

    if (_bandage in _includedTypes) then {
        // Create new wrapped wound
        private _newClassID = _id + 0.01;
        private _newBandage = _bandage + "_wrapped";
        private _newWound = [_newClassID, _amount, _bleeding, _damage, _newBandage];

        TRACE_2("Wound Before/After Wrap", _x, _newWound);

        // Add wrapped wound
        _newWounds pushBack _newWound;

        // Call ACE bandage handling
        private _impact = 1;
        private _woundIndex = count _newWounds - 1;
        [_patient, _impact, _bodyPart, _woundIndex, _newWound, _newBandage, false] call ACEFUNC(medical_treatment,handleBandageOpening);

        // Remove old wound using your logic
        private _indexToRemove = -1;
        {
            _x params ["_oldID", "_oldAmount", "", "", "_oldBandage"];
            if (_oldID == _id && {_oldBandage == _bandage}) exitWith {
                private _newAmount = 0 max (_oldAmount - 1);
                if (_newAmount == 0) then {
                    _indexToRemove = _forEachIndex;
                } else {
                    _x set [1, _newAmount]; // Decrement
                };
            };
        } forEach _newWounds;

        if (_indexToRemove != -1) then {
            _newWounds deleteAt _indexToRemove;
            if (_newWounds isEqualTo []) then {
                _bandagedWounds deleteAt _bodyPart;
            } else {
                _bandagedWounds set [_bodyPart, _newWounds];
            };
        } else {
            _bandagedWounds set [_bodyPart, _newWounds];
        };

        _wrappedAny = true;
    };
} forEach _wounds;

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];

_wrappedAny