#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Check if patient's body part can be treated by NPWT
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Can use NPWT <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_canNPWT
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _condition = ((GET_BANDAGED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []) || ((GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []);

if (_condition) then {
    private _isBleeding = false;
    { // ace_medical_treatment_fnc_canBandage
        _x params ["", "_amountOf", "_bleeding"]; 
        
        if (_amountOf * _bleeding > 0) exitWith {
            _isBleeding = true;
        };
    } forEach ((GET_OPEN_WOUNDS(_patient)) getOrDefault [_bodyPart, []]);
    _isBleeding
} else {
    _condition
};