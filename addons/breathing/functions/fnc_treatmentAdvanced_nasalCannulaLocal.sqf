#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Inserting Nasal Cannula
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 3: Treatment classname <STRING>
 * 4: Used Item <STRING>
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
_currentMonitors = _currentMonitors + [_className];

_patient setVariable [QGVAR(etco2Monitor), _currentMonitors, true];

for "_i" from 0 to (count _currentMonitors) -1 do {
	systemChat (_currentMonitors select _i);
};