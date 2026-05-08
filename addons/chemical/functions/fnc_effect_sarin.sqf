#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Sarin (GB). G-series nerve agent, fast-acting. REQUIRES CBRN suit.
 * Marks nerveAgentExposure (which the watcher gates on, and ATNAA clears)
 * and schedules the symptom chain: vomit -> unconscious -> cardiac arrest.
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

if ((_unit getVariable [QGVAR(nerveAgentExposure), ""]) isEqualTo "sarin") exitWith {};
_unit setVariable [QGVAR(nerveAgentExposure), "sarin", true];

private _vomit       = missionNamespace getVariable [QGVAR(sarin_vomitTime),         30];
private _unconscious = missionNamespace getVariable [QGVAR(sarin_unconsciousTime),   60];
private _cardiac     = missionNamespace getVariable [QGVAR(sarin_cardiacArrestTime), 90];

[_unit, _vomit, _unconscious, _cardiac] call FUNC(scheduleNerveSymptomChain);
