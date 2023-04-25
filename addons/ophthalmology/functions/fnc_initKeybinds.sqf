#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
/*
 * Author: Katalam
 * Initialize the keybinds.
 *
 * Return Value:
 * None
 *
 * Public: No
 *
 * https://community.bistudio.com/wiki/DIK_KeyCodes
 */

if (!hasInterface) exitWith {};

[QUOTE(COMPONENT_BEAUTIFIED), QGVAR(blinking), LLSTRING(blink_action),
{
    ACE_PLAYER setVariable [QGVAR(lastBlink), CBA_missionTime];
    GVAR(ppBlur) ppEffectEnable false;
    GVAR(ppBlur) ppEffectAdjust [0];
    GVAR(ppBlur) ppEffectCommit 0;

    GVAR(ppBlurBlink) ppEffectEnable true;
    GVAR(ppBlurBlink) ppEffectAdjust [0.5];
    GVAR(ppBlurBlink) ppEffectCommit 0.5;

    [{
        GVAR(ppBlurBlink) ppEffectEnable false;
        GVAR(ppBlurBlink) ppEffectAdjust [0];
        GVAR(ppBlurBlink) ppEffectCommit 0.5;
    }, [], 0.1] call CBA_fnc_waitAndExecute;
}, "",
[DIK_TAB, [false, false, false]], false] call CBA_fnc_addKeybind;
// [DIK, [shift, ctrl, alt]] 
