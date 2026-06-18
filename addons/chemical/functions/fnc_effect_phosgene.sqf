#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Phosgene (CG). Choking agent, mask-sufficient. Famous "silent killer" —
 * symptoms (pulmonary edema, severe shallow breathing) appear minutes after
 * exposure, even if the unit has already left the cloud.
 *
 * Schedules a single delayed pulmonary effect on first exposure. Subsequent
 * cloud ticks accumulate the dose variable but don't reschedule.
 *
 * Runs local to the unit's owner.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Infected source <OBJECT>
 * 2: Gas data <HASHMAP>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_infectedObject", "_gasData"];

private _dose = (_unit getVariable [QGVAR(phosgeneDose), 0]) + 1;
_unit setVariable [QGVAR(phosgeneDose), _dose, true];

if (_unit getVariable [QGVAR(phosgeneDeadline_onset), 0] > 0) exitWith {};

private _onsetMin = missionNamespace getVariable [QGVAR(phosgene_onsetMin), 120];
private _onsetMax = missionNamespace getVariable [QGVAR(phosgene_onsetMax), 360];
private _delay = _onsetMin + random (_onsetMax - _onsetMin);

_unit setVariable [QGVAR(phosgeneDeadline_onset), CBA_missionTime + _delay, true];

[_unit] call FUNC(addToExposureWatcher);
