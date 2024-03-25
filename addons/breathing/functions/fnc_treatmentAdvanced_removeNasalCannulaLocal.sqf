#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Removes Nasal Cannula from patient and returns it to medic if reusable airway items is enabled
 * Local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_treatmentAdvanced_removeNasalCannula;
 *
 * Public: No
 */

 params ["_medic", "_patient"];

_currentMonitors = _patient getVariable [QGVAR(etco2Monitor), []];
_currentMonitors deleteAt (_currentMonitors find "NasalCannula");

_patient setVariable [QGVAR(etco2Monitor),_currentMonitors,true];
_patient setVariable [QGVAR(nasalCannula),false,true];

[_patient, "activity", LSTRING(Remove_NasalCannula_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

if !(EGVAR(airway,ReusableAirwayItems)) exitWith {};
[_medic,"kat_nasal"] call ACEFUNC(common,addToInventory);
