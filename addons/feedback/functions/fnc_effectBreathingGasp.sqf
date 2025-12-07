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
 * [true, 0.5, player] call kat_feedback_fnc_effectBreathingGasp;
 *
 * Public: No
 */

params ["_unit"];

private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];
if (_soundTargets isNotEqualTo []) then {
    [QEGVAR(breathing,playGasp), [_unit], _soundTargets] call CBA_fnc_targetEvent;
};

