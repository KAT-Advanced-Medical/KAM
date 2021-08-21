#include "script_component.hpp"
/*
 * Author: YetheSamartaka
 * Ensures proper initial values reset on respawn (such as SpO2 value, pneumothorax and so on)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [alive, body] call kat_breathing_fnc_handleRespawn;
 *
 * Public: No
 */

params ["_unit","_dead"];
TRACE_2("handleRespawn",_unit,_dead);

if (!local _unit) exitWith {};

_unit setVariable ["KAT_medical_airwayStatus", 100, true];
_unit setVariable ["KAT_medical_airwayOccluded", false, true];
_unit setVariable ["KAT_medical_pneumothorax", false, true];
_unit setVariable ["KAT_medical_hemopneumothorax", false, true];
_unit setVariable ["KAT_medical_tensionpneumothorax", false, true];
_unit setVariable ["KAT_medical_activeChestSeal", false, true];

_unit setVariable [QGVAR(pulseoximeter), false, true];
_unit setVariable ["kat_PulseoxiInUse_PFH", nil];
_unit setVariable [QGVAR(o2), false, true];
_unit setVariable ["KAT_circulation_X", false, true];