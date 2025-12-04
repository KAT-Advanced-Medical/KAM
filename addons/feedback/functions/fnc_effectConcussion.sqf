#include "..\script_component.hpp"
/*
 * Author: apo_tle, MiszczuZPolski
 * Triggers the ICP effect.
 *
* Arguments:
 * 0: Enable <BOOL>
 * 1: Current CMR <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectConcussion;
 *
 * Public: No
 */

params ["_enable", "_concussionSeverity"];

// Early exit if system is disabled
if (!GVAR(enableBrainEffect)) exitWith {};

// Disable effect if switched off or severity is zero
if (!_enable || (_concussionSeverity <= 0)) exitWith {
    if (GVAR(ppConcussion) != -1) then {
        GVAR(ppConcussion) ppEffectEnable false;
        GVAR(ppConcussion) ppEffectAdjust [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        GVAR(ppConcussion) ppEffectCommit 0;
    };
};

// Ensure effect is on
if (GVAR(ppConcussion) != -1) then {
    GVAR(ppConcussion) ppEffectEnable true;
};

// Scale the severity
systemChat str _concussionSeverity;
private _ppMult = linearConversion [0, 10, _concussionSeverity, 1, 3, true];

// Apply the concussion visual effect
GVAR(ppConcussion) ppEffectAdjust [
    0.51,
    0.2,
    0.2,
    1 * _ppMult,
    1 * _ppMult,
    1 * _ppMult,
    1 * _ppMult,
    0.05 * _ppMult,
    0.01 * _ppMult,
    0.05 * _ppMult,
    0.01 * _ppMult,
    0.1 * _ppMult,
    0.1 * _ppMult,
    0.2 * _ppMult,
    0.2 * _ppMult
];

GVAR(ppConcussion) ppEffectCommit 1;