#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Triggers the wheezing effect.
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
 * [true, 0.5, player] call kat_feedback_fnc_effectBreathingWheeze;
 *
 * Public: No
 */

params ["_enable", "_effected", "_unit"];
if (!_enable || !_effected) exitWith { false };

if (!(_unit getVariable [QEGVAR(breathing,PneumoBreathCooldownOn), false])) then {
    _unit setVariable [QEGVAR(breathing,PneumoBreathCooldownOn), true, true];

    private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

    if !(_soundTargets isEqualTo []) then {
        [QEGVAR(breathing,playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
    };

    [{
        params["_unit"];
        _unit setVariable [QEGVAR(breathing,PneumoBreathCooldownOn), false, true];
    },
    [_unit], 20] call CBA_fnc_waitAndExecute;
};