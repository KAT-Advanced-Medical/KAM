#include "script_component"
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
    [0.2, false] call EFUNC(feedback,effectEyeBlink);

    private _random = floor(random 100);

    if (_random <= GVAR(probability_treatment_dust)) then {
        private _dustInjurySeverity = ACE_player getVariable [QGVAR(dustInjurySeverity), 0];
        ACE_player setVariable [QGVAR(dustInjurySeverity), ((_dustInjurySeverity - 0.5) max 0), true];
    };
}, "",
[DIK_TAB, [false, false, false]], false] call CBA_fnc_addKeybind;
// [DIK, [shift, ctrl, alt]]