#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Schedules the nerve-agent symptom chain (vomit -> unconscious -> cardiac arrest)
 * on a unit by writing deadline variables. The exposure watcher PFH fires the
 * effects when each deadline is reached, gated on the unit still having the
 * nerveAgentExposure variable set (so ATNAA can abort by clearing it).
 *
 * Idempotent: only schedules if not already scheduled.
 * Called server-side (or via targetEvent on owner).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vomit delay (seconds) <NUMBER>
 * 2: Unconscious delay (seconds) <NUMBER>
 * 3: Cardiac arrest delay (seconds) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_vomitDelay", "_unconsciousDelay", "_cardiacDelay"];

if (_unit getVariable [QGVAR(nerveDeadline_cardiac), 0] > 0) exitWith {};

private _now = CBA_missionTime;

_unit setVariable [QGVAR(nerveDeadline_vomit),       _now + _vomitDelay,       true];
_unit setVariable [QGVAR(nerveDeadline_unconscious), _now + _unconsciousDelay, true];
_unit setVariable [QGVAR(nerveDeadline_cardiac),     _now + _cardiacDelay,     true];

[_unit] call FUNC(addToExposureWatcher);
