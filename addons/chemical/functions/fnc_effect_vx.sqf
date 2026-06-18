#include "..\script_component.hpp"
/*
 * Author: DiGii
 * VX. V-series nerve agent — REQUIRES CBRN suit. Slower onset than Sarin but
 * persistent: the gas cloud lifetime is extended, AND the unit gets skin
 * contamination so the contamination tick keeps re-poisoning them until decon.
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

_unit setVariable [QGVAR(chemicalContamination), "vx", true];
[QGVAR(serverStartContaminationTick), [_unit]] call CBA_fnc_serverEvent;

if ((_unit getVariable [QGVAR(nerveAgentExposure), ""]) isEqualTo "vx") exitWith {};
_unit setVariable [QGVAR(nerveAgentExposure), "vx", true];

private _vomit       = missionNamespace getVariable [QGVAR(vx_vomitTime),         60];
private _unconscious = missionNamespace getVariable [QGVAR(vx_unconsciousTime),   120];
private _cardiac     = missionNamespace getVariable [QGVAR(vx_cardiacArrestTime), 180];

[_unit, _vomit, _unconscious, _cardiac] call FUNC(scheduleNerveSymptomChain);
