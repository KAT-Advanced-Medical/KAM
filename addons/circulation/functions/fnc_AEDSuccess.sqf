#include "script_component.hpp"
/*
 * Author: Glowbal
 * Handles finishing performing CPR on the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 1: ReviveObject <STRING> ()
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_medical_treatment_fnc_cprSuccess
 *
 * Public: No
 */

params [
	["_medic",objNull,[objNull]],
	["_patient",objNull,[objNull]],
	["_reviveObject","CPR",[""]]
];

//pain will be added to all units standing too close to caller or target.
if (vehicle _patient isEqualTo _patient) then {
	private _bystanders = ( allUnits select {_x distance _patient < 1.7} ) - [_medic];
	{ [_x, 0.2] remoteExec ["ace_medical_fnc_adjustPainLevel",_x]; nil; } count _bystanders;
};

_patient setVariable ["ace_medical_CPR_provider", objNull, true];

if (alive _patient && {_patient getVariable ["ace_medical_inCardiacArrest", false]}) then {
    ["ace_medical_treatment_cprLocal", [_medic, _patient, _reviveObject], _patient] call CBA_fnc_targetEvent;
};
