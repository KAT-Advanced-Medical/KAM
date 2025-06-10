#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Adds blood type to quick_view log
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_bloodTypeLog;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _weight = _patient getVariable [QGVAR(defaultWeight), 80];
[_patient, "quick_view", LSTRING(weight_log)] call FUNC(removeLog);
[_patient, "quick_view", LSTRING(weight_log), [[_medic] call ACEFUNC(common,getName), _weight]] call ACEFUNC(medical_treatment,addToLog);
