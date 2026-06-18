#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Server-side: starts the contamination tick PFH for a unit if not already
 * running. Idempotent. Triggered via QGVAR(serverStartContaminationTick)
 * server event from per-gas effect functions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if (isNull _unit) exitWith {};
if (_unit getVariable [QGVAR(contaminationPFHActive), false]) exitWith {};
_unit setVariable [QGVAR(contaminationPFHActive), true, true];

[LINKFUNC(contaminationTickPFH), 5, [_unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
