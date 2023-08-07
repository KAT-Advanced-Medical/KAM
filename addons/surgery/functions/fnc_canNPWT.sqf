#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Check if patient's body part can be healed by NPWT
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

private _isBleeding = false;
{
    _x params ["", "_amountOf", "_bleedingRate"];
    _isBleeding = _amountOf > 0 && {_bleedingRate > 0};
    if (_isBleeding) then {break};
} forEach (GET_OPEN_WOUNDS(_patient) get _bodyPart);

(!_isBleeding && {(GET_DEBRIDED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []} || {(GET_STITCHED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []}) // return
