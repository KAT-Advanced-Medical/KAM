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

private _bloodPressure = [_patient] call ace_medical_status_fnc_getBloodPressure;
_bloodPressureH = _bloodPressure select 1;

if (_bloodPressureH >= 110 && _bloodPressureH <= 130 && (random 100 <= GVAR(carbonateChance))) then {
    [_patient, false] call ace_medical_status_fnc_setUnconsciousState;
};