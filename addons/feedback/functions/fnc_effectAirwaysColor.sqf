#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Digii
 * Modified by MiszczuZPolski
 * Triggers the low SPO2 visual effect.
 *
* Arguments:
 * 0: Enable <BOOL>
 * 1: Intensity <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 0.5] call kat_feedback_fnc_effectairwayInjury;
 *
 * Public: No
 */

params ["_enable", "_enabled", "_intensity"];
if ((!_enable) || (!_enabled)) exitWith {
    GVAR(airwayInjuryColor) ppEffectEnable false;
    ACE_player setVariable [QGVAR(airwayInjuryColorTime), 0];
};
private _time = ACE_player getVariable [QGVAR(airwayInjuryColorTime), 0];
if (_time == 0) then {
    ACE_player setVariable [QGVAR(airwayInjuryColorTime), CBA_missionTime];
};

GVAR(airwayInjuryColor) ppEffectEnable true;
GVAR(airwayInjuryColor) ppEffectAdjust [1, 1, 0, [0, 0, 0, 0],  [1, 1, 1, 1 - _intensity],  [0.2, 0.2, 0.2, 0]];
GVAR(airwayInjuryColor) ppEffectCommit 1;