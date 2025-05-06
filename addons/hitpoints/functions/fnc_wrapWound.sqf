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

params ["_patient", "_bodyPart"];

private _bandagedWounds = _patient getVariable [VAR_BANDAGED_WOUNDS, []];
if (isNil "_bandagedWounds") exitWith {false};

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
if (_bandagedWoundsOnPart isEqualTo []) exitWith {false};
TRACE_1("WrapAllWounds1",_bandagedWoundsOnPart);

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze", "Burn_Dressing", "Hemostatic_Gauze"];

private _wrappedAny = false;

{
    private _bandageType = _x param [4, ""];
    if (_bandageType in _includedTypes) then {
        private _classID = (_x select 0) + 0.1;
        private _amount = _x select 1;
        private _bleeding = _x select 2;
        private _damage = _x select 3;
        private _oldBandage = _bandageType;

        private _newClassID = _classID + 0.01;
        private _newEntry = [
            _newClassID,
            _amount,
            _bleeding,
            _damage,
            _oldBandage + "_wrapped"
        ];

        TRACE_2("Wound Before/After Wrap", _x, _newEntry);

        _bandagedWoundsOnPart set [_forEachIndex, _newEntry];
        _bandagedWounds set [_bodyPart, _bandagedWoundsOnPart];

        private _impact = 1;
        private _woundIndex = _forEachIndex;
        private _wound = _newEntry;
        private _bandage = _oldBandage + "_wrapped";

        TRACE_6("WrapWound",_patient,_impact,_bodyPart,_woundIndex,_wound,_bandage);
        [_patient, _impact, _bodyPart, _woundIndex, _wound, _bandage, false] call ACEFUNC(medical_treatment,handleBandageOpening);

        _wrappedAny = true;
    };
} forEach _bandagedWoundsOnPart;

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];

_wrappedAny