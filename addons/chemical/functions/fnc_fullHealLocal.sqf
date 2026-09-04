#include "..\script_component.hpp"
/*
 * Author: Glowbal, Brett Mayson
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_treatment_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal kat chemical",_patient);

_patient setVariable [QGVAR(gasmask_durability), 10, true];
_patient setVariable [QGVAR(CSGas), 0, true];
_patient setVariable [QGVAR(airPoisoning), false, true];
_patient setVariable [QGVAR(infectionTime), missionNamespace getVariable [QGVAR(chlorine_onsetTime), 60], true];
_patient setVariable [QGVAR(chlorineLastTick), -1e9, true];
_patient setVariable [QGVAR(infectionArray), [], true];
_patient setVariable [QGVAR(CoughCooldown), false, true];

// New chemical-warfare exposure state
_patient setVariable [QGVAR(currentCloudGasId), "", true];
_patient setVariable [QGVAR(lastCloudExposure), -1e9, true];
_patient setVariable [QGVAR(smelledGases), [], true];
_patient setVariable [QGVAR(nerveAgentExposure), "", true];
_patient setVariable [QGVAR(chemicalContamination), "", true];
_patient setVariable [QGVAR(phosgeneDose), 0, true];
_patient setVariable [QGVAR(phosgeneDeadline_onset), 0, true];
_patient setVariable [QGVAR(mustardDeadline_eye), 0, true];
_patient setVariable [QGVAR(mustardDeadline_burn), 0, true];
_patient setVariable [QGVAR(mustardBurnActive), false, true];
_patient setVariable [QGVAR(nerveDeadline_vomit), 0, true];
_patient setVariable [QGVAR(nerveDeadline_unconscious), 0, true];
_patient setVariable [QGVAR(nerveDeadline_cardiac), 0, true];
