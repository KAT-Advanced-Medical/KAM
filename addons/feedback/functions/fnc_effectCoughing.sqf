#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski & Digii
 * Triggers the coughing effect.
 *
 * Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity <NUMBER>
 * 2: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5, player] call kat_feedback_fnc_effectCoughing;
 *
 * Public: No
 */

params ["_enable", "_poisoned", "_unit"];
if (!_enable || !_poisoned) exitWith {
    if (GVAR(airPoisoning) != -1) then { GVAR(airPoisoning) ppEffectEnable false; };
};
if (GVAR(airPoisoning) != -1) then { GVAR(airPoisoning) ppEffectEnable true; };

if (!(_unit getVariable [QEGVAR(chemical,CoughCooldown), false])) then {
    _unit setVariable [QEGVAR(chemical,CoughCooldown), true, true];

    private _random = floor (random 4);
    switch (_random) do {
        case 0: { _unit say3D QEGVAR(chemical,cough_0); };
        case 1: { _unit say3D QEGVAR(chemical,cough_1); };
        case 2: { _unit say3D QEGVAR(chemical,cough_2); };
        case 3: { _unit say3D QEGVAR(chemical,cough_3); };
    };

    addCamShake [3, 4, 0];

    [{
        params["_unit"];
        _unit setVariable [QEGVAR(chemical,CoughCooldown), false, true];
    },
    [_unit], 7] call CBA_fnc_waitAndExecute;
};

// Trigger effect every 2s
private _showNextTick = missionNamespace getVariable [QGVAR(showCoughNextTick), true];
GVAR(showCoughNextTick) = !_showNextTick;
if (_showNextTick) exitWith {};

private _initialAdjust = [];
private _delayedAdjust = [];

private _intensity = linearConversion [0, 1, 0.5, 0, 0.06, true];
_initialAdjust = [_intensity, _intensity, true];
_delayedAdjust = [_intensity * 0.15, _intensity * 0.15, true];

GVAR(airPoisoning) ppEffectAdjust _initialAdjust;
GVAR(airPoisoning) ppEffectCommit FX_COUGH_FADE_IN;

[{
    params ["_adjust"];
    GVAR(airPoisoning) ppEffectAdjust _adjust;
    GVAR(airPoisoning) ppEffectCommit FX_COUGH_FADE_OUT;
}, [_delayedAdjust], 3] call CBA_fnc_waitAndExecute;
