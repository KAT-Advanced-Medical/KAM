#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Attaches BVM to a Patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_breathing_fnc_attachBVM
 *
 * Public: No
 */

params ["_medic", "_patient"];
_patient setVariable [QGVAR(attachedVent), false, true];

_currentMonitors = _patient getVariable [QGVAR(etco2Monitor), []];
_currentMonitors deleteAt (_currentMonitors find "Ventilator");

_patient setVariable [QGVAR(etco2Monitor), _currentMonitors, true];

[_patient, "activity", LSTRING(Removed_Vent_log), [[_medic] call ACEFUNC(common,getName), LSTRING(Ventilator_Display)]] call ACEFUNC(medical_treatment,addToLog);