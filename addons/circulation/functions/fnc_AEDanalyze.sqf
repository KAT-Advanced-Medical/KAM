#include "script_component.hpp"
/*
 * Author: Katalam
 * Handle the X Series Defi for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_circulation_fnc_treatmentAdvanced_X;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _bloodLoss = _patient getVariable ["ace_medical_bloodVolume", 6.0];
private _asystole = _patient getVariable [QGVAR(asystole), 0];

if (_asystole isEqualTo 0) then {
	if (_bloodLoss <= 2.8) then {
		_patient setVariable [QGVAR(asystole), 2, true];
	} else {
		_patient setVariable [QGVAR(asystole), 1, true];
	};
};

playsound3D [QPATHTOF_SOUND(sounds\analyse.wav), _patient, false, getPosASL _patient, 5, 1, 15];

// wait for the analyse and give the advise
if (_patient getVariable ["ace_medical_heartRate", 0] == 0 && _asystole <= 1) then {
    [{
        params ["_patient"];
        playsound3D [QPATHTOF_SOUND(sounds\shock.wav), _patient, false, getPosASL _patient, 6, 1, 15];
    }, [_patient], 2] call CBA_fnc_waitAndExecute;
} else {
    [{
        params ["_patient"];
        playsound3D [QPATHTOF_SOUND(sounds\noshock.wav), _patient, false, getPosASL _patient, 6, 1, 15];
    }, [_patient], 2] call CBA_fnc_waitAndExecute;
};

true