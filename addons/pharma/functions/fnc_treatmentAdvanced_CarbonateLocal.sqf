#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CarbonateLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _sedated = _patient getVariable [QEGVAR(surgery,sedated), false];
if (_sedated) exitWith {};

private _bloodPressure = [_patient] call ACEFUNC(medical_status,getBloodPressure);
_bloodPressureH = _bloodPressure select 1;

if (_bloodPressureH >= 100 && _bloodPressureH <= 140 && (random 100 <= GVAR(carbonateChance)) && {[_patient] call ACEFUNC(medical_status,hasStableVitals)}  ) then {
    [_patient, false] call ACEFUNC(medical,setUnconscious);
};