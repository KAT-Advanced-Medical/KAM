#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Check for time to wrap a limb
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body part ("Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg") <STRING>
 *
 * Return Value:
 * Number
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_getWrapTime
 *
 * Public: No
 */

params ["", "_patient", "_bodyPart"];

((count ((_patient getVariable ["ace_medical_bandagedWounds", []]) getOrDefault [_bodyPart, []])) * 4) min 16