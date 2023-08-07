#include "script_component.hpp"
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
 * [player, cursorObject, "head"] call kat_surgery_fnc_getDebrideTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];

((count (GET_DEBRIDED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) * GVAR(woundDebrideTime)) + (count (GET_STITCHED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) * GVAR(npwtTime)))
