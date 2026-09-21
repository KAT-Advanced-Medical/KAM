#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

[CBA_SETTINGS_CAT, QGVAR(blinking), LLSTRING(blink_action),
{
    [0.2, false] call EFUNC(feedback,effectEyeBlink);

    private _random = floor(random 100);

    if (_random <= GVAR(probability_treatment_dust)) then {
        // Blinking removes 0.5 of dust, light dust first
        private _dustInjuryLight = ACE_player getVariable [QGVAR(dustInjuryLight), 0];
        private _dustInjuryHeavy = ACE_player getVariable [QGVAR(dustInjuryHeavy), 0];
        private _removedLight = _dustInjuryLight min 0.5;

        ACE_player setVariable [QGVAR(dustInjuryLight), _dustInjuryLight - _removedLight, true];
        ACE_player setVariable [QGVAR(dustInjuryHeavy), (_dustInjuryHeavy - (0.5 - _removedLight)) max 0, true];
    };
}, "",
[DIK_F, [true, true, false]], false] call CBA_fnc_addKeybind;
// [DIK, [shift, ctrl, alt]]
