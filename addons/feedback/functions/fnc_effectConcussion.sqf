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
private _concussion = ACE_player getVariable [QEGVAR(brain,concussion), 0];
// Disable effect if switched off or severity is zero
if (!_enable || (_concussion <= 0)) exitWith {
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

private _ppMult = linearConversion [0, 1, _concussion, 1, 8, true];

// Apply the concussion visual effect
GVAR(ppConcussion) ppEffectAdjust [
    0.51,
    0.2,
    0.2,
    1,
    1,
    1,
    1,
    0.05 * (_ppMult * random [0.6, 1, 1.4]),
    0.01 * (_ppMult * random [0.6, 1, 1.4]),
    0.05 * (_ppMult * random [0.6, 1, 1.4]),
    0.01 * (_ppMult * random [0.6, 1, 1.4]),
    0,
    0,
    0,
    0
];

GVAR(ppConcussion) ppEffectCommit 1;