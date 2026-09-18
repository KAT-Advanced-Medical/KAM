#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Starts the owner-local radiation-physiology tick for a unit if not already
 * running. Drives the ongoing dose-dependent sub-syndromes (anemia, GI,
 * hypotension, fever, visual feedback) and handles spontaneous recovery.
 * Idempotent.
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
if (_unit getVariable [QGVAR(radPhysiologyPFHActive), false]) exitWith {};
_unit setVariable [QGVAR(radPhysiologyPFHActive), true, true];

[LINKFUNC(radPhysiologyPFH), 5, [_unit]] call CBA_fnc_addPerFrameHandler;
