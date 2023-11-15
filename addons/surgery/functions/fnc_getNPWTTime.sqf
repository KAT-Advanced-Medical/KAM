#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Calculates the Debride treatment time based on the amount of debridable wounds.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Treatment Time <NUMBER>
 *
 * Example:
 * [player, cursorObject, "head"] call kat_surgery_fnc_getNPWTTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];

private _woundCount = 0;
{ // ace_medical_treatment_fnc_canBandage
    _x params ["_id", "_amountOf", "_bleeding"]; 
    
    if (_amountOf * _bleeding > 0) then {
        _woundCount = _woundCount + 1;
    };
} forEach ((GET_OPEN_WOUNDS(_patient)) getOrDefault [_bodyPart, []]);

if (_woundCount > 0) then {
    _woundCount * GVAR(npwtTime)
} else {
    count (GET_BANDAGED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) * GVAR(npwtTime)
};
