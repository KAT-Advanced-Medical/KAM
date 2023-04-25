#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the current moment if blinking was needed in the past
 * and ands pp effects if needed
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_pfhID"];

if !(GVAR(enableManualBlinking)) exitWith {};

private _lastBlink = _unit getVariable [QGVAR(lastBlink), 0];

if (CBA_missionTime > _lastBlink + GVAR(blink_duration)) then {
    GVAR(ppBlur) ppEffectEnable true;
    GVAR(ppBlur) ppEffectAdjust [GVAR(blink_effect_intensity)];
    GVAR(ppBlur) ppEffectCommit GVAR(blink_duration);
};
