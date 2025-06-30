#include "..\script_component.hpp"
/*
 * Author: Mazinski.H, Blue
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

private _sedated = _patient getVariable [QEGVAR(surgery,sedated), 0];
if (_sedated > 0.1) exitWith {};

private _bloodPressure = GET_BLOOD_PRESSURE(_unit);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
private _map = _bloodPressureL + (0.3333333333 * (_bloodPressureH - _bloodPressureL));

if ((floor (random 100) < ((linearConversion [60, 93, _map, 0, GVAR(carbonateChance), true]) min (linearConversion [93, 120, _map, GVAR(carbonateChance), 0, true]))) && {[_patient] call EFUNC(vitals,hasStableVitals)}) then {
    [_patient, false] call ACEFUNC(medical,setUnconscious);
};
