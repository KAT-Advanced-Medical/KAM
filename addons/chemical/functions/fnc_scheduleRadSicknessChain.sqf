#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Schedules the staged radiation-sickness chain by writing deadline variables,
 * which the exposure watcher PFH consumes. Mirrors fnc_scheduleNerveSymptomChain
 * but unlocks stages by ARS tier and compresses delays at higher tiers.
 *
 * Per-stage deadline convention:
 *   0  = never scheduled (eligible)
 *  >0  = pending (fires when CBA_missionTime reaches it)
 *  -1  = already fired (set by the watcher). Re-armed only when the tier had
 *        dropped below that stage and is now rising past it again (a new
 *        exposure episode), so a stage never repeats while the tier holds.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: ARS tier (1..4) <NUMBER>
 * 2: Delay scale (shorter at higher tiers) <NUMBER>
 * 3: Previous ARS tier (0..3) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_tier", "_scale", ["_previousTier", 0]];

private _now = CBA_missionTime;

private _fnc_sched = {
    params ["_var", "_delay", "_minTier"];
    private _deadline = _unit getVariable [_var, 0];
    if (_deadline == 0 || {_deadline < 0 && {_previousTier < _minTier}}) then {
        _unit setVariable [_var, _now + (_delay * _scale), true];
    };
};

if (_tier >= 1) then {
    if (_previousTier < 1 && {(_unit getVariable [QGVAR(radDeadline_prodromal), 0]) < 0}) then {
        _unit setVariable [QGVAR(radTimeToVomit), -1, true];
    };
    [QGVAR(radDeadline_prodromal), GVAR(rad_prodromalDelay), 1] call _fnc_sched;
};
if (_tier >= 2) then {
    [QGVAR(radDeadline_hema), GVAR(rad_hemaDelay), 2] call _fnc_sched;
};
if (_tier >= 3) then {
    [QGVAR(radDeadline_gi), GVAR(rad_giDelay), 3] call _fnc_sched;
};
if (_tier >= 4) then {
    [QGVAR(radDeadline_cns), GVAR(rad_cnsDelay), 4] call _fnc_sched;
    if (!GVAR(rad_lethalCurable)) then {
        [QGVAR(radDeadline_cardiac), GVAR(rad_cardiacDelay), 4] call _fnc_sched;
    };
};

[_unit] call FUNC(addToExposureWatcher);
