#include "..\script_component.hpp"
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

private _openWounds = GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []];

private _isBleeding = false;

if (_openWounds isNotEqualTo []) then {
    { // ace_medical_treatment_fnc_canBandage 
        _x params ["_woundClassID", "_amountOf", "_bleeding"];
        private _classIndex = _woundClassID / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        if (_amountOf * _bleeding > 0 && !(_classname in ["InternalBleeding"])) exitWith {
            _isBleeding = true;
        };
    } forEach _openWounds;
};

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient) getOrDefault [_bodyPart, []];

private _isNotInternal = false;

if (_bandagedWounds isNotEqualTo []) then {
    { // ace_medical_treatment_fnc_canBandage 
        _x params ["_woundClassID"];
        private _classIndex = _woundClassID / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        if !(_classname in ["InternalBleeding"]) exitWith {
            _isNotInternal = true;
        };
    } forEach _bandagedWounds;
};

(_isBleeding || _isNotInternal);