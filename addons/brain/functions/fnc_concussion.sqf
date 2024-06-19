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
private _chanceMultiplier = linearConversion [0,3,(["vehiclehit","explosive","shell","vehiclecrash"] find _ammo),1,1.5,true];

private _concussionChance = (GVAR(concussionChance) + _chanceIncrease) * _chanceMultiplier;
if (floor (random 100) <= _concussionChance) then {
	private _currentSeverity = _unit getVariable [QGVAR(concussionSeverity),0])
	private _newSeverity = linearConversion [0, 3,_damage,0,1,true];
	if (_newSeverity > _currentSeverity) then { //Replace the current concussion with the more severe one
		if !(_currentSeverity isEqualTo 0) then { //Delete the existing concussion PFH if it exists
			private _existingPFH = _unit getVariable [QGVAR(concussionPFH),0];
			[_existingPFH] call CBA_fnc_removePerFrameHandler;
		}
		
		[{
		params ["_args", "_idPFH"];
		_args params ["_unit","_severity"];
		if !(alive _unit) exitWith {
			_unit setVariable [QGVAR(concussionPFH),0,true];
			_unit setVariable [QGVAR(concussionSeverity),0,true];
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		}, 15, [_unit,_newSeverity]] call CBA_fnc_addPerFrameHandler;
	}
	
};