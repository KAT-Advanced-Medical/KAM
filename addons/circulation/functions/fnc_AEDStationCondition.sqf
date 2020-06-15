#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if AED Station can be performed on the patient.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Can CPR <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDStationCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _canCPR = ["",_patient] call ace_medical_treatment_fnc_canCPR;
private _classNameObjects = [];
{
	_className = typeOf _x; 
	_classNameObjects pushBack _className;
} forEach nearestObjects [position player, ['Land_Defibrillator_F'], 3]; 

if (!(_classNameObjects isEqualTo []) && {_canCPR}) exitWith {true};

false
