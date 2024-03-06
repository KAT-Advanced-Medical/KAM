#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Calculate patient's ETCo2 level based on status of their vitals
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * ETCo2 level <INT>
 *
 * Example:
 * [player] call kat_breathing_fnc_getETCo2;
 *
 * Public: No
 */

 params ["_patient"];


_baseValue = 40;

_hr = 0;
_sp02 = 0;
_bloodloss = 0;

_hasPtx = false;
_ptxFactor = 0;

_airwayObstructed = false;
_airwayOccluded = false;

_airwayBlocked = (_airwayObstructed || _airwayOccluded) // TODO replace vars with functions to get states