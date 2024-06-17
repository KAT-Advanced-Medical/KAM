#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_brain_fnc_init
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
if !(GVAR(enable)) exitWith {};

_unit setVariable [QGVAR(CMR),20,true];
_unit setVariable [QGVAR(CBF),800,true];
_unit setVariable [QGVAR(CVR),0.1,true];
_unit setVariable [QGVAR(ICP),10,true];

_unit setVariable [QGVAR(activityPFH), [_unit] call EFUNC(brain,handleBrainActivity),true];