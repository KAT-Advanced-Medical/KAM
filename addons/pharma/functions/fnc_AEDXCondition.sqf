#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if AED X can be performed on the patient.
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Can CPR <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDXCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _canCPR = ["",_patient] call ace_medical_treatment_fnc_canCPR;
private _hasMonitor = _patient getVariable [QGVAR(X), false];

if (((_hasMonitor)
|| ([_medic, 'kat_X_AED'] call ace_common_fnc_hasItem))
&& {_canCPR}) exitWith {true};

false