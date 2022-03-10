#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Checks for Reorientation Wakeup values to restore consciousness
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_ReorientationLocal;
 *
 * Public: No
 */

params ["_medic", "_target"];

if (random(100) <= GVAR(Reorient_successChance)) then {

	private _bloodVolume = GET_BLOOD_VOLUME(_target);
	private _pulse = GET_HEART_RATE(_target);

	if (_bloodVolume > 5.1 && _pulse >= 70 && _pulse <= 100) then {
		[_target, false] call ace_medical_fnc_setUnconscious;
	};
};

true
