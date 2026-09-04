#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Implements the legacy in-cloud infection countdown used by chlorine.
 * Each tick the unit is in a chlorine cloud, the countdown decrements;
 * when it reaches 0 the unit gets airPoisoning + cough.
 *
 * Lifted from the original fnc_poison.sqf:60-82 logic, parameterized by
 * the chlorine_onsetTime CBA setting.
 *
 * Called locally on the affected unit per gas-cloud tick.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Infected source object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_infectedObject"];

private _currentInfectionArray = _unit getVariable [QGVAR(infectionArray), []];

if ((_currentInfectionArray findIf {_x isEqualTo _infectedObject}) == -1) then {
    _currentInfectionArray append [_infectedObject];
};

_unit setVariable [QGVAR(infectionArray), _currentInfectionArray, true];

private _maxOnset = missionNamespace getVariable [QGVAR(chlorine_onsetTime), 30];
private _currentInfection = _unit getVariable [QGVAR(infectionTime), _maxOnset];

private _now = CBA_missionTime;
private _timeOutOfCloud = (_now - (_unit getVariable [QGVAR(chlorineLastTick), -1e9])) - GAS_MANAGER_PFH_DELAY;

if (_timeOutOfCloud > 0) then {
    _currentInfection = (_currentInfection + _timeOutOfCloud) min _maxOnset;
};

_unit setVariable [QGVAR(chlorineLastTick), _now, true];

private _timeLeft = (_currentInfection - 1) max 0;

if (_currentInfection != _timeLeft) then {
    _unit setVariable [QGVAR(infectionTime), _timeLeft, true];
};

if (_timeLeft <= 0) then {
    if !(_unit getVariable [QGVAR(airPoisoning), false]) then {
        [QEGVAR(breathing,playCough), [_unit], _unit] call CBA_fnc_targetEvent;
    };
    _unit setVariable [QGVAR(airPoisoning), true, true];
};
