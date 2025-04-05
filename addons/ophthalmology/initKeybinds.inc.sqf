#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

[CBA_SETTINGS_CAT, QGVAR(blinking), LLSTRING(blink_action),
{
    [0.2, false] call EFUNC(feedback,effectEyeBlink);

    private _random = floor(random 100);

    if (_random <= GVAR(probability_treatment_dust)) then {
        private _dustInjurySeverity = ACE_player getVariable [QGVAR(dustInjurySeverity), 0];
        ACE_player setVariable [QGVAR(dustInjurySeverity), ((_dustInjurySeverity - 0.5) max 0), true];
    };
}, "",
[DIK_F, [true, true, false]], false] call CBA_fnc_addKeybind;
// [DIK, [shift, ctrl, alt]]