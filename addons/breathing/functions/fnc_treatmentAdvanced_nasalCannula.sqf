#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Inserting Nasal Cannula
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "Head", "NasalCannula", objNull, "kat_nasal"] call kat_breathing_fnc_treatmentAdvanced_nasalCannula;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[QGVAR(nasalCannulaLocal), [_medic, _patient, _classname, _usedItem], _patient] call CBA_fnc_targetEvent;
