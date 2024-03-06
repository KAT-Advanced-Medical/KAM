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

private _bloodType = _patient getVariable [QGVAR(bloodtype), "O_N"];
private _bloodTypeLog = "";
switch (_bloodType) do {
    case "A": { _bloodTypeLog = "A+" };
    case "A_N": { _bloodTypeLog = "A-" };
    case "B": { _bloodTypeLog = "B+" };
    case "B_N": { _bloodTypeLog = "B-" };
    case "AB": { _bloodTypeLog = "AB+" };
    case "AB_N": { _bloodTypeLog = "AB-" };
    case "O": { _bloodTypeLog = "0+" };
    default { _bloodTypeLog = "0-" };
};

[_patient, "quick_view", LSTRING(bloodtype_log)] call FUNC(removeLog);
[_patient, "quick_view", LSTRING(bloodtype_log), [[_medic] call ACEFUNC(common,getName), _bloodTypeLog]] call ACEFUNC(medical_treatment,addToLog);
