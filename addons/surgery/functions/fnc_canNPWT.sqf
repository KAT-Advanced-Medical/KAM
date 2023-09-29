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

((GET_BANDAGED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo [])
||((GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo [])
