#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Accumulates inhaled dose for one gas tick and converts it into a lung injury severity,
 * which it hands to the breathing addon through the public setLungInjury event.
 *
 * Dose is a concentration-time product (Haber's law). Cloud intensity is squared because the
 * gas manager's falloff is linear while real puff concentration falls off far faster - this
 * is what makes the edge of a cloud meaningfully safer than standing on the shell.
 *
 * Runs local to the unit, called from the per-gas effect functions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gas data <HASHMAP>
 * 2: Cloud intensity, 0 to 1 <NUMBER>
 * 3: Apply the result now? false accumulates silently, for agents with delayed onset
 *    such as phosgene (optional, default true) <BOOL>
 *
 * Return Value:
 * Resulting severity, 0 to 1 <NUMBER>
 *
 * Example:
 * [player, _gasData, 0.5] call kat_chemical_fnc_accumulateLungDose;
 *
 * Public: No
 */

params ["_unit", "_gasData", ["_intensity", 1], ["_apply", true]];

if !(LUNG_MODEL_ACTIVE) exitWith { 0 };

private _potency = _gasData getOrDefault ["lungPotency", 0];
private _cap = _gasData getOrDefault ["lungInjuryCap", 0];

if (_potency <= 0 || {_cap <= 0}) exitWith { 0 };

private _now = CBA_missionTime;
private _last = _unit getVariable [QGVAR(lungDoseLastTick), -1e9];
private _deltaT = ((_now - _last) min GAS_MANAGER_PFH_DELAY) max 0;

_unit setVariable [QGVAR(lungDoseLastTick), _now];

private _lct = (_gasData getOrDefault ["lungLCt", 60]) max 1;
private _dose = _unit getVariable [QGVAR(lungDose), 0];

// Two poison events in the same frame, overlapping clouds, or a contamination tick landing on a cloud tick.
if (_deltaT <= 0) exitWith { ((_dose / _lct) min 1) * _cap };

_intensity = ((_intensity max 0) min 1);

_dose = _dose + ((_intensity ^ LUNG_DOSE_INTENSITY_EXP) * _potency * _deltaT * GVAR(lungInjuryMultiplier));
_unit setVariable [QGVAR(lungDose), _dose, true];

private _severity = ((_dose / _lct) min 1) * _cap;

if (_apply) then {
    [QEGVAR(breathing,setLungInjury), [_unit, _severity, _gasData getOrDefault ["id", ""], _gasData getOrDefault ["lungProgression", 0], _gasData getOrDefault ["lungProgressiveMin", LUNG_INJURY_PROGRESSIVE_MIN]]] call CBA_fnc_localEvent;
};

_severity
