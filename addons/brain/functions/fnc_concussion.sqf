#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Called when a unit is hit. Handles receiving TBIs and setting up dedicated PFHs to increase ICP.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *  0: Damage <NUMBER>
 *  1: Bodypart <STRING>
 * 2: Shooter <OBJECT>
 * 3: Ammo classname or damage type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Head"], objNull, "BulletBase"] call kat_brain_fnc_concussion
 *
 * Public: No
 */

 params ["_unit", "_allDamages", "", "_ammo"];
_allDamages select 0 params ["_damage", "_bodyPart"];

if (!(GVAR(enable)) || !(_bodyPart isEqualTo "Head")) exitWith {};

// Increase the chance based on how much damage was received 
private _chanceIncrease = linearConversion [0,1,_damage,5,30,true];
// Increase the chance of concussions depending on the damage type
private _chanceMultiplier = 1;
if (_ammo in ["vehiclehit","explosive","shell","vehiclecrash"]) then {
	_chanceMultiplier = linearConversion [0,3,(["vehiclehit","explosive","shell","vehiclecrash"] find _ammo),1.2,2,true];
};

private _concussionChance = (GVAR(concussionChance) + _chanceIncrease) * _chanceMultiplier;
if (floor (random 100) <= _concussionChance) then {
	private _currentSeverity = _unit getVariable [QGVAR(concussionSeverity),0];
	if (_damage > _currentSeverity) then { //Replace the current concussion with the more severe one
		// Add instantaneous effects from concussions
		if (_damage > GVAR(necrosisImpactDamage)) then { // Cause instant necrosis if threshold is surpassed
			private _necrosis = _unit getVariable [QGVAR(necrosis),0];
			private _newNecrosis = linearConversion [0, 1,_damage,0,7,true]; //Increase tissue necrosis by 7% max on impact
			if (_newNecrosis > _necrosis) then { // Prevent reverting existing necrosis levels
				_unit setVariable [QGVAR(necrosis),_newNecrosis,true]; 
			};
		};
		if (_damage > GVAR(tissueImpactDamage)) then { // Cause reversible tissue damage if threshold is surpassed
			private _reversibleDamage = _unit getVariable [QGVAR(reversibleDamage),0];
			_reversibleDamage = _reversibleDamage + (linearConversion [0,1,_damage,0,25,true]); //Increase reversible damage by max 25% on impact
			_unit setVariable [QGVAR(reversibleDamage),_reversibleDamage,true];
		};

		// Increase ICP to a base level depending on damage taken
		private _ICP = _unit getVariable [QGVAR(ICP),10];
		private _ICPincrease = linearConversion [0, 1,_damage,1,3,true];
		_unit setVariable [QGVAR(ICP),_ICP+_damage,true];

		// Set up PFH
		if !(_currentSeverity isEqualTo 0) then { //Delete the existing concussion PFH if it exists
			private _existingPFH = _unit getVariable [QGVAR(concussionPFH),0];
			[_existingPFH] call CBA_fnc_removePerFrameHandler;
		};

		private _maxICPIncrease = linearConversion [0,1,_damage,0,40];
		private _newPFH = [{
			params ["_args", "_idPFH"];
			_args params ["_unit","_severity","_maxICPIncrease"];
			if !(alive _unit) exitWith {
				_unit setVariable [QGVAR(concussionPFH),0,true];
				_unit setVariable [QGVAR(concussionSeverity),0,true];
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};

			private _ICP = _unit getVariable [QGVAR(ICP),10];
			
			//Kill the concussion once ICP reaches the limit for the concussion's severity
			if (_ICP >= (20+_maxICPIncrease)) exitWith {
				_unit setVariable [QGVAR(concussionPFH),0,true];
				_unit setVariable [QGVAR(concussionSeverity),0,true];
				[_idPFH] call CBA_fnc_removePerFrameHandler;
			};
			
			private _ICPincrease = linearConversion [0,1,_severity,0,2,true];
			_unit setVariable [QGVAR(ICP),_ICP+_ICPincrease,true]; //Increase ICP by concussion severity

		}, 10, [_unit,_damage,_maxICPIncrease]] call CBA_fnc_addPerFrameHandler;
		
		_unit setVariable [QGVAR(concussionPFH),_newPFH,true];
		_unit setVariable [QGVAR(concussionSeverity),_damage,true];
	}
	
};