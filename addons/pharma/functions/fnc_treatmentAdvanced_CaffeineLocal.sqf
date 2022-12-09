#include "script_component.hpp"
/*
 * Author: Miss Heda
 * 
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * -
 *
 * Public: No
 */

params ["_patient"];

/// ACE Fatigue 

if (ACEGVAR(advanced_fatigue,enabled)) then {

	[{
		params ["_patient"];
		ace_advanced_fatigue_anReserve = ace_advanced_fatigue_anReserve + 1500;
	},
	[_patient], 5] call CBA_fnc_waitAndExecute;
	
} else {

	[{
		params ["_patient"];
		_patient setStamina(getStamina _patient + 300);
	},
	[_patient], 5] call CBA_fnc_waitAndExecute;

};