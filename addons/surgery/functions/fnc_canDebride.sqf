#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Checks if debridement can be performed
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Can Perform Debridement <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_canDebride;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

((GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo [])
