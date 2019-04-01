#include "script_component.hpp"
/*
 * Author: Katalam
 * Check if unit has a pulse oximeter applied to the specified bodypart
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * Has pulse oximeter applied <BOOL>
 *
 * Example:
 * [player, "leftleg"] call kat_breathing_fnc_hasPulseoxiAppliedTo
 *
 * Public: No
 */

params ["_target", "_bodyPart"];

private _index = ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"] find toLower _bodyPart;

_index >= 0 && {((_target getVariable [QGVAR(pulseoximeter), [0,0,0,0,0,0]] select _index) > 0)}
