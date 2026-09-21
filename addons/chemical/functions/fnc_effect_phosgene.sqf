#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Phosgene (CG). Choking agent, mask-sufficient. Famous "silent killer" -
 * symptoms (pulmonary edema, severe shallow breathing) appear minutes after
 * exposure, even if the unit has already left the cloud.
 *
 * Dose accumulates silently while in the cloud and drives both how soon symptoms arrive and
 * how bad they get: a whiff gives the full walking-wounded latency, a lungful crashes fast.
 *
 * Runs local to the unit's owner.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Infected source <OBJECT>
 * 2: Gas data <HASHMAP>
 * 3: Cloud intensity, 0 to 1 (optional, default 1) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_infectedObject", "_gasData", ["_intensity", 1]];

private _onsetMin = missionNamespace getVariable [QGVAR(phosgene_onsetMin), 120];
private _onsetMax = missionNamespace getVariable [QGVAR(phosgene_onsetMax), 360];

if !(LUNG_MODEL_ACTIVE) exitWith {
    _unit setVariable [QGVAR(phosgeneDose), (_unit getVariable [QGVAR(phosgeneDose), 0]) + 1, true];

    if (_unit getVariable [QGVAR(phosgeneDeadline_onset), 0] > 0) exitWith {};

    _unit setVariable [QGVAR(phosgeneDeadline_onset), CBA_missionTime + _onsetMin + random (_onsetMax - _onsetMin), true];

    [_unit] call FUNC(addToExposureWatcher);
};

// Accumulate without applying - the whole point of phosgene is that the casualty feels fine.
private _severity = [_unit, _gasData, _intensity, false] call FUNC(accumulateLungDose);

if (_unit getVariable [QGVAR(lungOnsetFired), false]) exitWith {
    [QEGVAR(breathing,setLungInjury), [_unit, _severity, "phosgene", _gasData getOrDefault ["lungProgression", 0], _gasData getOrDefault ["lungProgressiveMin", LUNG_INJURY_PROGRESSIVE_MIN]]] call CBA_fnc_localEvent;
};

private _lct = (_gasData getOrDefault ["lungLCt", 60]) max 1;
private _doseFraction = (((_unit getVariable [QGVAR(lungDose), 0]) / _lct) min 1);
private _deadline = CBA_missionTime + (_onsetMax - ((_onsetMax - _onsetMin) * _doseFraction));

// Keep the earliest deadline - continued exposure can only bring symptoms forward.
private _existing = _unit getVariable [QGVAR(phosgeneDeadline_onset), 0];
_unit setVariable [QGVAR(phosgeneDeadline_onset), ([_deadline, _existing min _deadline] select (_existing > 0)), true];

[_unit] call FUNC(addToExposureWatcher);
