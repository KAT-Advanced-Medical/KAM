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
params ["_unit"];
if (_unit getVariable [QEGVAR(vitals,simpleMedical), false]) exitWith {};
 if (!local _unit) then {
    [QGVAR(handleBrainActivity), [_unit], _unit] call CBA_fnc_targetEvent;
};

if !(GVAR(enable) || (isNil QGVAR(activityPFH))) exitWith {};

private _newPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    if !(alive _unit) exitWith {
        _unit setVariable [QGVAR(activityPFH),nil,true];
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
	_deoxygenatedTicks = [_deoxygenatedTicks + 0.25, _deoxygenatedTicks - 0.5] select (_rO2 > GVAR(necrosisThreshold));
	_deoxygenatedTicks = (_deoxygenatedTicks max 0) min 100;
	_unit setVariable [QGVAR(deoxygenatedTicks),_deoxygenatedTicks,true];
	if (_deoxygenatedTicks >= GVAR(necrosisTicks)) then {
		_necrosis = (_necrosis + GVAR(necrosisIncrease)) min 100;
		if (_necrosis > random [75, 85, 100]) then {
			[_unit, "Fatal_Brain_Necrosis"] call ACEFUNC(medical_status,setDead);
		};
	};

	private _reversibleDamage = _unit getVariable [QGVAR(reversibleDamage),0];

	//Finally, calculate total brain metabolic rate
	private _CMR = 100 * ((100-_necrosis)/100) * ((100-_reversibleDamage)/100);

	_unit setVariable [QGVAR(necrosis),_necrosis,true];
	_unit setVariable [QGVAR(CMR),_CMR,true];

	private _ICP = _unit getVariable [QGVAR(ICP),15];
	
	if !(_unit getVariable [QGVAR(isSwelling), false]) then {
		
		//Reduce ICP if no longer swelling
		private _salineFlow = ((_unit getVariable [QGVAR(salineFlow), 0]) / 5) min 5;
		private _metoprololCount = ([_unit, "Metoprolol", false] call ACEFUNC(medical_status,getMedicationCount)) select 1;
		private _metoprolol = linearConversion [0, 1, _metoprololCount, 1, 1.5];
		private _icpReduction = GVAR(ICPreduction) * (1 + _salineFlow) * GVAR(ICPreductionMult) * _metoprolol;
		private _newICP = _ICP - _icpReduction;
		private _hasSaline = [_unit] call FUNC(findSaline);
		// Set "floors" for ICP, preventing ICP from returning to normal levels without saline
		if (_salineFlow == 0 && !_hasSaline) then {
			switch (true) do {
				case (_ICP >= 45): {
					_newICP = 45 max _newICP;
				};
				case (_ICP >= 38): {
					_newICP = 38 max _newICP;
				};
				case (_ICP >= 25): {
					_newICP = 25 max _newICP;
				};
				default { //Prevent ICP from returning to normal without saline
					_newICP = 15 max _newICP;
				};
			};
		};
		_newICP = 15 max _newICP;
		_unit setVariable [QGVAR(ICP),_newICP,true];
		private _reversibleDamageDiff = ((_reversibleDamage - GVAR(reversibleDamageLoss)) max 0) min 100;
		//Reduce reversible tissue damage
		_unit setVariable [QGVAR(reversibleDamage),_reversibleDamageDiff,true];
	};

	//Cause LOC if CMR becomes too low
	if (_CMR <= GVAR(CMRunconsciousThreshold) && !(_unit getVariable ["ACE_isUnconscious",false])) then {
		private _CMRunconIncrease = linearConversion [0, GVAR(CMRunconsciousThreshold), _CMR, 50, 0, true];
		if (((floor (random 100) + _CMRunconIncrease)  >= GVAR(CMRunconsciousChance)) && (_CMR >= GVAR(stableCMR))) exitWith {};
		[QACEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
	};
}, 5, [_unit]] call CBA_fnc_addPerFrameHandler;
_unit setVariable [QGVAR(activityPFH),_newPFH,true];