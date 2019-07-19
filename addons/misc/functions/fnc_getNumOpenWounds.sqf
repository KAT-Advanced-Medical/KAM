#include "script_component.hpp"
/*
 * Author: Schwaggot EDIT: Katalam
 * Will count the open unbandaged wounds for given player.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * 0: Open unbandaged wounds <NUMBER>
 *
 * Example:
 * [cursorTarget] call KAM_misc_fnc_getNumOpenWounds;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]]];

private _openWounds = _unit getVariable ["ace_medical_openWounds", []];

// nothing to do here
if (count _openWounds == 0) exitWith {0};

private _headWounds = 0;
private _bodyWounds = 0;
private _leftArmWounds = 0;
private _leftLegWounds = 0;
private _rightArmWounds = 0;
private _rightLegWounds = 0;

// Loop through all current wounds and add up the number of unbandaged wounds on each body part.
{
    _x params ["", "", "_bodyPart", "_numOpenWounds", "_bloodLoss"];

    if(_bloodLoss > 0) then {
        switch (_bodyPart) do {
            // Head
            case 0: {
                _headWounds = _headWounds + _numOpenWounds;
            };

            // Body
            case 1: {
                _bodyWounds = _bodyWounds + _numOpenWounds;
            };

            // Left Arm
            case 2: {
                _leftArmWounds = _leftArmWounds + _numOpenWounds;
            };

            // Right Arm
            case 3: {
                _rightArmWounds = _rightArmWounds + _numOpenWounds;
            };

            // Left Leg
            case 4: {
                _leftLegWounds = _leftLegWounds + _numOpenWounds;
            };

            // Right Leg
            case 5: {
                _rightLegWounds = _rightLegWounds + _numOpenWounds;
            };
        };
    };
} forEach _openWounds;

_headWounds + _bodyWounds + _leftArmWounds + _leftLegWounds + _rightArmWounds + _rightLegWounds;
