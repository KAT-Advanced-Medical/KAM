#include "script_component.hpp"
/*
 * Author: Katalam EDIT: Katalam
 * Will bandage random wounds for given player
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call KAM_misc_fnc_bandageRandomWound;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]]];

private _openWounds = _unit getVariable ["ace_medical_openWounds", []];

private _headWounds = 0;
private _bodyWounds = 0;
private _leftArmWounds = 0;
private _leftLegWounds = 0;
private _rightArmWounds = 0;
private _rightLegWounds = 0;

// get all bleeding body parts
private _woundedBodyParts = [];
{
    _x params ["", "", "_bodyPart", "_numOpenWounds", "_bloodLoss"];

    if(_bloodLoss > 0) then {
        switch (_bodyPart) do {
            // Head
            case 0: {
                _woundedBodyParts pushBackUnique "head";
                _headWounds = _headWounds + _numOpenWounds;
            };

            // Body
            case 1: {
                _woundedBodyParts pushBackUnique "body";
                _bodyWounds = _bodyWounds + _numOpenWounds;
            };

            // Left Arm
            case 2: {
                _woundedBodyParts pushBackUnique "hand_l";
                _leftArmWounds = _leftArmWounds + _numOpenWounds;
            };

            // Right Arm
            case 3: {
                _woundedBodyParts pushBackUnique "hand_r";
                _rightArmWounds = _rightArmWounds + _numOpenWounds;
            };

            // Left Leg
            case 4: {
                _woundedBodyParts pushBackUnique "leg_l";
                _leftLegWounds = _leftLegWounds + _numOpenWounds;
            };

            // Right Leg
            case 5: {
                _woundedBodyParts pushBackUnique "leg_r";
                _rightLegWounds = _rightLegWounds + _numOpenWounds;
            };
        };
    };
} forEach _openWounds;

// preferablly bandage head and torso wounds first
if("head" in _woundedBodyParts) then {
    private _i = 0;
    for [{_i = 0}, {_i < _headWounds}, {_i = _i + 1}] do {
        [_unit, _unit, "head", "Bandage"] call ace_medical_fnc_treatmentAdvanced_bandage;
    };
};

if("body" in _woundedBodyParts) then {
    private _i = 0;
    for [{_i = 0}, {_i < _bodyWounds}, {_i = _i + 1}] do {
        [_unit, _unit, "body", "Bandage"] call ace_medical_fnc_treatmentAdvanced_bandage;
    };
};

private _sumOpenWounds = _leftArmWounds + _leftLegWounds + _rightArmWounds + _rightLegWounds;

// if no head or torso wound was closed, choose at random
if(_sumOpenWounds > 4) then {
    private _selection = selectRandom (_woundedBodyParts - ["head","body"]);
    [_unit, _unit, _selection, "Bandage"] call ace_medical_fnc_treatmentAdvanced_bandage;
};
