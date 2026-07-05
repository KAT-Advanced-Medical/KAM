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
 *  -1  = already fired (set by the watcher; not rescheduled)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: ARS tier (1..4) <NUMBER>
 * 2: Delay scale (shorter at higher tiers) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_tier", "_scale"];

private _now = CBA_missionTime;

private _fnc_sched = {
    params ["_var", "_delay"];
    if ((_unit getVariable [_var, 0]) == 0) then {
        _unit setVariable [_var, _now + (_delay * _scale), true];
    };
};

if (_tier >= 1) then {
    [QGVAR(radDeadline_prodromal), GVAR(rad_prodromalDelay)] call _fnc_sched;
};
if (_tier >= 2) then {
    [QGVAR(radDeadline_hema), GVAR(rad_hemaDelay)] call _fnc_sched;
};
if (_tier >= 3) then {
    [QGVAR(radDeadline_gi), GVAR(rad_giDelay)] call _fnc_sched;
};
if (_tier >= 4) then {
    [QGVAR(radDeadline_cns), GVAR(rad_cnsDelay)] call _fnc_sched;
    if (!GVAR(rad_lethalCurable)) then {
        [QGVAR(radDeadline_cardiac), GVAR(rad_cardiacDelay)] call _fnc_sched;
    };
};

[_unit] call FUNC(addToExposureWatcher);
