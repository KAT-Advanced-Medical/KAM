#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Inserting Nasal Cannula
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 * 3: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "NasalCannula", "kat_nasal"] call kat_breathing_fnc_treatmentAdvanced_nasalCannulaLocal;
 *
 * Public: No
 */

params ["_medic", "_patient","_classname", "_usedItem"];

_currentMonitors = _patient getVariable [QGVAR(etco2Monitor),[]];
_currentMonitors pushBack _classname;

_patient setVariable [QGVAR(etco2Monitor),_currentMonitors,true];
_patient setVariable [QGVAR(nasalCannula),true,true];

[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ELSTRING(airway,airway_log), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);