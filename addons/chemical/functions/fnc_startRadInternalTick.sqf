#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Starts the owner-local internal-burden tick for a unit if not already
 * running. Converts internalised radionuclides into committed whole-body dose
 * over time and decays the burden (faster while a chelation window is active).
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
if (_unit getVariable [QGVAR(radInternalPFHActive), false]) exitWith {};
_unit setVariable [QGVAR(radInternalPFHActive), true, true];

[LINKFUNC(radInternalTickPFH), 5, [_unit]] call CBA_fnc_addPerFrameHandler;
