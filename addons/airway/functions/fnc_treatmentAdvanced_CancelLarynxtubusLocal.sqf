#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Removing Larynxtubus
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_CancelLarynxtubusLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(kingLTisSet), false, true];
_patient setVariable [QGVAR(airway_item), "", true];
_patient call FUNC(handleAirway);
_patient call FUNC(handlePuking);

if (GVAR(reusableAirwayItems)) then {
	if (_medic canAdd "kat_larynx") then {
		_medic addItem "kat_larynx";
	} else {
		_patient addItem "kat_larynx";
	};
};
