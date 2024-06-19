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

	// Calculate brain oxygen saturation
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

	//Calculate tissue necrosis and brain death
	private _necrosis = _unit getVariable [QGVAR(necrosis),0];
	private _deoxygenatedTicks = _unit getVariable [QGVAR(deoxygenatedTicks),0];
	_deoxygenatedTicks = [_deoxygenatedTicks + 1,_deoxygenatedTicks - 2] select (rO2 < GVAR(necrosisThreshold));
	_deoxygenatedTicks = (0 max _dexoxygenation) min GVAR(necrosisTicks);
	if 	(_deoxygenatedTicks == GVAR(necrosisThreshold)) then {
		_necrosis = (_necrosis + GVAR(necrosisIncrease)) min 100;
		//TODO kill unit when this gets too high
	};

	private _reversibleDamage = _unit getVariable [QGVAR(reversibleDamage),0];

	//Finally, calculate total brain metabolic rate
	_CMR = 20 * (rO2/80) * ((100-_necrosis)/100) * ((100-_reversibleDamage)/100);

	_unit setVariable [QGVAR(necrosis),_necrosis,true];
	_unit setVariable [QGVAR(CMR),_CMR,true];

	//Reduce ICP if no longer swelling
	if (_unit getVariable [QGVAR(concussionPFH),0] isEqualTo 0) then {
		private _ICP = _unit getVariable [QGVAR(ICP),15];
		private _newICP = _ICP - GVAR(ICPreduction);
		
		// Set "floors" for ICP, preventing ICP from returning to normal levels without pain suppression
		if (GET_PAIN_SUPPRESS(_unit) < 0.6) then {
			switch (true) do {
				case (ICP >= 45): {
					_newICP = 45 max _newICP;
				};
				case (ICP >= 38): {
					_newICP = 38 max _newICP;
				};
				default { //Prevent ICP from returning to normal without medication
					_newICP = 25 max _newICP;
				};
			};
		};
		_newICP = 15 max _newICP;
		_unit setVariable [QGVAR(ICP),_newICP,true];
	};

}, 15, [_unit]] call CBA_fnc_addPerFrameHandler;

true;