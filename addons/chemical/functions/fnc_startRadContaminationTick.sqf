#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Starts the owner-local external-contamination tick for a unit if not already
 * running. Decays surface contamination over time and keeps the unit's
 * cross-contamination source (server-side) in sync. Idempotent.
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
if (_unit getVariable [QGVAR(radContamPFHActive), false]) exitWith {};
_unit setVariable [QGVAR(radContamPFHActive), true, true];

[LINKFUNC(radContaminationTickPFH), 5, [_unit]] call CBA_fnc_addPerFrameHandler;
