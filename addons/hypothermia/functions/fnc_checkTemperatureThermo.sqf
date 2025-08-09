#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks patient temperature
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_hypothermia_fnc_checkTemperature;
 *
 * Public: No
 */
params ["_medic", "_patient"];

private _unitTemperature = ceil (_patient getVariable [QGVAR(unitTemperature), 37]);

[_patient, "quick_view", LSTRING(Thermometer_log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(Thermometer_log), [[_medic, false, true] call ACEFUNC(common,getName), _unitTemperature]] call ACEFUNC(medical_treatment,addToLog);
