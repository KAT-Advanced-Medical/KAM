#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Chlorine (legacy "Toxic Gas" / KAT_toxicLvL = 1). Choking agent, mask-sufficient.
 * Behaves identically to the pre-refactor toxic gas — uses the per-tick infection
 * countdown so existing missions are unaffected.
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

[_unit, _infectedObject] call FUNC(scheduleAirPoisoningOnset);
