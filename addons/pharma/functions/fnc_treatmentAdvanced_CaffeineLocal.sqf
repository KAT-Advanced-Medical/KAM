#include "script_component.hpp"
/*
 * Author: Miss Heda, 
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

	ace_advanced_fatigue_anReserve = ace_advanced_fatigue_anReserve + 1500;

} else {

	_patient setStamina(getStamina _patient + 300);

};