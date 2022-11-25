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

private _canCPR = ["",_patient] call ACEFUNC(medical_treatment,canCPR);
private _hasMonitor = _patient getVariable [QGVAR(X), false];
private _recovery = _patient getVariable[QEGVAR(airway,recovery),false];

if (((_hasMonitor)
|| ([_medic, "kat_X_AED"] call ACEFUNC(common,hasItem)))
&& {!_recovery}
&& {_canCPR}) exitWith {true};

false