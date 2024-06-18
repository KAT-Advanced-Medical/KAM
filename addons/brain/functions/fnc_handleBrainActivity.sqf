#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles the simulation of oxygen perfusion into the brain and therefore the metabolic rate.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * 0: PFH enabled <BOOL>
 *
 * Example:
 * [bob] call kat_brain_fnc_handleBrainActivity
 *
 * Public: No
 */

 if (!local _unit) then {
    [QGVAR(handleBrainActivity), [_unit], _unit] call CBA_fnc_targetEvent;
};

if (!GVAR(enable) || _unit getVariable [QGVAR(activityPFH),false]) exitWith {
    true
};

[{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        _unit setVariable [QGVAR(activityPFH),false,true];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

	private _CPR = _unit getVariable [QGVAR(CPR),100];
	private _perfusionDelta = switch (true) do { // Calculate change in rO2 based on graph
		case (_CPR <= 50): {-3};
		case (_CPR <= 100): {(_CPR/10) - 8};
		case (_CPR <= 110): {2};
		case (_CPR <= 121.052): {(_CPR/30) - (5/3)};
		case (_CPR <= 160): {(_CPR/-8) + 17.5};
		default {-2.5};
	};

	private _rO2 = _unit getVariable [QGVAR(rO2),80];
	_rO2 = (0 max (_rO2 + _perfusionDelta)) min 80; // Transform rO2 by the perfusion delta within bounds of 0 and 80
	_unit setVariable [QGVAR(rO2),_rO2,true];

}, 15, [_unit]] call CBA_fnc_addPerFrameHandler;

true;